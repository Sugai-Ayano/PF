class Batch::DataReset
  def self.data_reset
    #Recommendationの中を空にする
    Recommendation.destroy_all
    Post.all.shuffle.take(1).each do |post|
      Recommendation.create(recommendation_params(post))
    end
    #投稿全て中から1つランダムに取得
    #Recommendationの中に投稿を追加させる
    p "おすすめの投稿"

  end
    #ストロングパラメータでidを判定する。
  def self.recommendation_params(post)
    {
      user_id: post.user_id,
      post_id: post.id
    }
  end
end