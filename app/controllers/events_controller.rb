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
    

    def show
        @event = Event.find(params[:id])
    end
    
    private

    def event_params
        params.require(:event).permit(:title, :description, :location)
    end
end
