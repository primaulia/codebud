class MessagesController < ApplicationController
  def index
    # @user = User.find(params[:user_id])
    @question = Question.find(params[:question_id])
<<<<<<< HEAD

=======
    @order = @question.selected_proposal.order
>>>>>>> master
    @message = Message.new
    if @question.user == current_user || @question.selected_proposal.user == current_user
      render :index
    else
      render :index #:not_authorized
    end
  end

  def create
    @question = Question.find(params[:question_id])
    @receiver = @question.selected_proposal.user
    @message = Message.new(params_message)
    @message.receiver_id = @receiver.id
    @message.sender_id = current_user.id
    @message.question = @question
    authorize @message

    if @message.save
      # looks for partial _message.html.erb if not default look for _message.json
      MessageChannel.broadcast_to(
        @question,
        render_to_string(partial: "message", formats: [:html], locals: { message: @message })
      )
    else
      render "/index"
    end
  end

  private

  def params_message
    params.require(:message).permit(:content)
  end
end
