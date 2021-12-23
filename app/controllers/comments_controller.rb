class CommentsController < ApplicationController

    def create
        comment = Comment.new(params[:comment].permit(:topic_id, :title, :name, :body))
        if comment.save
            flash[:success] = "コメントしました"
            redirect_back(fallback_location: root_path)
        else
            flash[:success] = "コメントできませんでした"
            redirect_back(fallback_location: root_path)
        end
    end

    private  
        def comment_params
            params.require(:comment).permit(:name, :body, :image)
        end
    end
