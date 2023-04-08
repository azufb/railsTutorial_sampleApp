class ApplicationController < ActionController::Base
    def greeting
        render html: 'Hello world!'
    end
end
