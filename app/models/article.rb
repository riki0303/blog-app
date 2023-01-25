# == Schema Information
#
# Table name: articles
#
#  id         :integer          not null, primary key
#  content    :text             not null
#  title      :string           not null
#  created_at :datetime         not null
#  updated_at :datetime         not null
#  user_id    :integer          not null
#
# Indexes
#
#  index_articles_on_user_id  (user_id)
#
class Article < ApplicationRecord
    has_one_attached :eyecatch

    validates :title, presence: true
    validates :title, length: {minimum: 2, maximum:100}
    validates :title, format: { with: /\A(?!\@)/ }

    validates :content, presence: true
    validates :content, length: {minimum: 10}
    validates :content, uniqueness: true

    # validate :validate_tittle_and_content_lengthh

    # 複数形で記述
    has_many :comments, dependent: :destroy
		has_many :likes, dependent: :destroy
    # 単数系で記述
    belongs_to :user

    def display_created_at
        I18n.l(self.created_at, format: :default)
    end

    def author_name
        user.display_name
    end

    def like_count
        likes.count
    end

    # private
    # def validate_tittle_and_content_length
    #     char_count = self.title.length + content.length
    #     unless char_count > 100
    #         errors.add(:content, "100文字以上で!!")
    #     end
    # end
end
