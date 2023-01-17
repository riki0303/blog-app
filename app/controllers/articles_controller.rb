class ArticlesController < ApplicationController
    before_action :set_article, only: [:show]
    before_action :authenticate_user!, only: [:new, :create, :edit, :update, :destroy]

    def index
        @articles = Article.all
    end

    def show
      @comments = @article.comments
    end

    def new
        @article = current_user.articles.build
    end

    def create
        @article = current_user.articles.build(article_params)
        if @article.save
          redirect_to article_path(@article), notice: '保存出来ました'
        else
            flash.now[:error] = '保存に失敗しました'
            render :new, status: :unprocessable_entity
        end
      end

      def edit
        @article = current_user.articles.find(params[:id])
      end

      def update
        @article = current_user.articles.find(params[:id])
        if @article.update(article_params)
            redirect_to article_path(@article), notice: '更新出来ました'
        else
        flash.now[:error] = '更新に失敗しました'
            render :edit, status: :unprocessable_entity
        end
      end

    #   Railsにおけるインスタンス変数の意味
    #     ①通常のインスタンス変数
    # 　　 ②viewに埋め込む
    # 　　　下記destroyの、articleはviewの中に埋め込まないためインスタンス変数として書いていない
      def destroy
        article = current_user.articles.find(params[:id])
        article.destroy!
        redirect_to root_path, notice: '削除に成功しました'
      end

      private
      def article_params
        params.require(:article).permit(:title, :content)
      end

      def set_article
        @article = Article.find(params[:id])
      end

end
