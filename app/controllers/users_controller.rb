# frozen_string_literal: true

class UsersController < ApplicationController
  def destroy
    user = User.find(params[:id])
    user.destroy!
    user.forget_me!
    redirect_to root_url, notice: '退会しました。'
  end
end
