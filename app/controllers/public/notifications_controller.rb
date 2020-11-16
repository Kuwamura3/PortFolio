class Public::NotificationsController < ApplicationController

	def destroy_all
	end

	def create
		@notification = Notification.new(notification_params)
		@notification.user_id = current_user.id
		if @notification.save
			# サクセスメッセージ
			@followers = current_user.followers
			@followers.each do |follower|
				@notification = Notification.new(notification_params)
				@notification.user_id = follower.id
				@notification.save
			end
			redirect_to user_path(params[:sender_id])
		else
			# エラーメッセージ
			@user = User.find(params[:sender_id])
			@users_games = current_user.playings.order(:game_id)
			@users_comments = UsersComment.where(commented_id: params[:id]).order(id: "DESC") #降順
			render template: "public/users/show"
		end
	end

	def destroy
	end

	private

	def notification_params
		params.permit(:sender_id, :game_id, :kind)
	end

end
