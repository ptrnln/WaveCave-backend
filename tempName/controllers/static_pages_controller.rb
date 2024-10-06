class StaticPagesController < ActionController::Base

    def api_index
        render file: Rails.root.join('app/public', 'api_index.html')
    end
end