class EventsController < ApplicationController
    before_action :authenticate_user!, except: %i[ index show ]
    def index
        @events = Event.all
    end

    def new
        @event = Event.new
    end

    def create
        @event = current_user.created_events.build(event_params)
        if @event.save
          flash[:success] = "Event successfully created"
          redirect_to @event
        else
          flash[:error] = "Something went wrong"
          render 'new'
        end
    end

    def edit
        @event = Event.find(params[:id])
    end
    
    def update
        @event = Event.find(params[:id])
        if @event.update(event_params)
          flash[:success] = "Event was successfully updated"
          redirect_to @event
        else
          flash[:error] = "Something went wrong"
          render 'edit'
        end
    end

    def rsvp
      @event = Event.find(params[:id])
      if @event.attendees.include?(current_user)
        redirect_to @event, notice: "You are already on the list"
      else
        @event.attendees << current_user
        redirect_to @event
      end
    end
  
    def cancel_rsvp
      @event = Event.find(params[:id])
      @event.attendees.delete(current_user)
      redirect_to @event, notice: "You are no longer attending this event"
    end
    

    def show
        @event = Event.find(params[:id])
    end
    
    private

    def event_params
        params.require(:event).permit(:title, :description, :date_time, :location)
    end
end
