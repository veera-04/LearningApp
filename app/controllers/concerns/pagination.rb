module Pagination
    def pagination_dict(object,stats={})
        meta={
            current_page: object.current_page,
            total_pages: object.total_pages,
            next_page: object.next_page,
            previous_page: object.previous_page,
            total_count: object.total_count
        }
        meta.merge!(stats) unless stats.blank?
        return meta
    end

end