class Comment < ApplicationRecord
    validates :body, presence: true

    belongs_to :commentable, polymorphic: true
    belongs_to :user

    has_many :replies, class_name: :Comment, foreign_key: :parent_id, dependent: :destroy

    belongs_to :parent, class_name: :Comment, optional: true

    def self.top_level_comments
        self.where(parent_id: nil)
    end

    def self.replies_to(comment)
        self.where(parent_id: comment.id)
    end
    
end
