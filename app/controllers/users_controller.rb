class UsersController < ApplicationController
  before_action :set_parents, only: [:index,:new,:show] #applicationControllerを継承しているのでこのコントローラで定義しなくてもset_paramsメソッドは使えます。
  def show
  end
end
