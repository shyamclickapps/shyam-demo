class PortfolioSerializer < ActiveModel::Serializer
      attributes :id,:name,:description,:projectarea,:avatar,:start_date,:end_date     

      def avatar_url  
          object.avatar.present? ?  ActionController::Base.asset_host + object.avatar.url(:original): ActionController::Base.asset_host + "/assets/profile.png"  
      end
end