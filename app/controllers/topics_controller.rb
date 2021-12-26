class TopicsController < ApplicationController
    def top
        @topic = Topic.all.order(created_at: :desc)
        if params[:search] == nil
                @topics= Topic.all.order(created_at: :desc)
            elsif params[:search] == ''
                @topics= Topic.all.order(created_at: :desc)
            else
            #部分検索
            @topics = Topic.where("title LIKE ? ",'%' + params[:search] + '%')
        end
        @newTopic = Topic.new
    end
    
    def new
        @topic = Topic.new
    end

    def index
        @topics= Topic.all.order(created_at: :desc).page(params[:page]).per(10)
        if params[:search] == nil
            @topics= Topic.all.order(created_at: :desc).page(params[:page]).per(10)
        elsif params[:search] == ''
            @topics= Topic.all.order(created_at: :desc).page(params[:page]).per(10)
        else
        #部分検索
            @topics = Topic.where("title LIKE ? ",'%' + params[:search] + '%').order(created_at: :desc).page(params[:page]).per(10)
        end
        @topic = Topic.new

        @topicss = Comment.joins(:topic).group(:title).order('count_all DESC').count

        @all_ranks = Topic.find(Comment.group(:topic_id).order('count(topic_id) desc').limit(3).pluck(:topic_id))
    
    end

    def show
        @topic = Topic.find(params[:id])
        @newcomment = Comment.new(:topic_id => params[:id])
        @comments = @topic.comments
        @comment = Comment.new
    end

    def create
        @topic = Topic.new(params[:topic].permit(:name, :title, :body))
        if @topic.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
        
    end

    def edit
        @topic = Topic.find(params[:id])
    end

    def update
        topic = Topic.find(params[:id])
        if topic.update(topic_params)
            redirect_to :action => "show", :id => topic.id
        else
            redirect_to :action => "new"
        end
    end
    
    def delete
    @topic = Topic.find(params[:id])
    @topic.destroy
    redirect_to topics_path
end



    private
    def topic_params
        params.require(:topic).permit(:name, :title, :body, :created_at)
    end
end
