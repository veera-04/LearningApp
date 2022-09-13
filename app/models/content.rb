class Content < ApplicationRecord
    belongs_to :chapter
    enum content_type: {
        video: 1,
        pdf: 2
    }

end
