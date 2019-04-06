class ArticlesController < ApplicationController
  before_action :authenticate_user!
	before_action :find_article, only: [:show, :edit, :update, :destroy]
  before_action :validate_user, only: [:show, :edit, :update, :destroy]
 
  def index
  	@articles = current_user.articles.order(created_at: :desc)
  end

  def show
  end

  def new
  	@article = Article.new
  end

  def edit
  end

  def create
  	@article = Article.new(article_params)
    @article.user_id = current_user.id
  	if @article.save
  		redirect_to @article, notice: '作成できたばい！'
  	else
  		render :new, alert: '作成できんかったばい。。。'
  	end
  end

  def update
  	if @article.update(article_params)
  		redirect_to @article, notice: '更新できたばい！'
  	else
  		render :edit, alert: '更新できんかったばい。。。'
  	end
  end

  def destroy
  	if @article.destroy
  		redirect_to root_path, notice: '削除できたばい！'
  	else
  		redirect_to root_path, alert: '削除できんかったばい。。。'
  	end
  end


  private

  def find_article
   	@article = Article.find(params[:id])
  end

  def article_params
  	params.require(:article).permit(:title, :body)
  end

  def validate_user
    if @article.user != current_user
    redirect_to root_path, alert: 'おまさん自分の投稿だけみんかい！覗き見すんな！'
    end
  end
end