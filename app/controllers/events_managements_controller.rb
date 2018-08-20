class EventsManagementsController < ApplicationController
  layout "index", only: [:created_events, :invited_events, :search_events]
  before_action :user_signed_in?, only: [:created_events, :invited_events, :search_events]
  before_action :get_invited_events, only: [:invited_events]
  before_action :get_created_events, only: [:created_events]

  def created_events; end

  def invited_events; end

  def search_events
    @q = current_user.events.search(params[:q])
    @result = Kaminari.paginate_array(@q.result).page(params[:page]).per Settings.paginate.per_page
  end

  def destroy
    @out_event = UserEvent.find_by event_id: params[:id], user_id: current_user.id
    @event = Event.find_by id: params[:id]
    if @out_event.destroy
      flash[:success] = t ".deleted"
      @status = true
    else
      flash[:warning] = t ".delete_fail"
      @status = false
    end
    respond_to :js
  end

  private

  def get_invited_events
    inv_event = current_user.user_events.select{|e| e.permission.zero?}.map do |ev|
      current_user.events.find_by(id: ev.event_id)
    end
    @invited_events = Kaminari.paginate_array(inv_event.sort_by{|t| t[:time_from]}).page(params[:page]).per Settings.paginate.per_page
  end

  def get_created_events
    cre_event = current_user.user_events.select{|e| e.permission == 1}.map do |ev|
      current_user.events.find_by(id: ev.event_id)
    end
    @created_events = Kaminari.paginate_array(cre_event.sort_by{|t| t[:time_from]}).page(params[:page]).per Settings.paginate.per_page
  end
end
