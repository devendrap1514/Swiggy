class OwnersController < UsersController
  def create
    @owner = Owner.new(user_params)
    if @owner.save
      render json: @owner, status: :created
    else
      render json: { errors: @owner.errors.full_messages },
             status: :unprocessable_entity
    end
  end
end
