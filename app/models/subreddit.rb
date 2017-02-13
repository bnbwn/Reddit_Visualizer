
class Subreddit < ApplicationRecord
  has_many :subreddit_origin_connections,
    foreign_key: "subreddit_to_id",
    class_name: "SubredditConnection"
  has_many :origin_subreddits,
    through: :subreddit_origin_connections, source: :subreddit_from

  has_many :subreddit_destination_connections,
    foreign_key: "subreddit_from_id",
    class_name: "SubredditConnection"
  has_many :destination_subreddits,
    through: :subreddit_destination_connections,
    source: :subreddit_to

  def find_or_fetch_by_name(subreddit_name)
    if where(name: subreddit_name).empty?
      subreddit = new(name: subreddit_name, 
      url: "/r/#{subreddit_name}",
      subscriber_count: get_sub_count(subreddit_name))
      subreddit.save
    else
      subreddit = where(name: subreddit_name).last
    end

    subreddit
  end
end
