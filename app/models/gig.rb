class Gig < ActiveRecord::Base
  include Ownable
  include Locationable

  scope :ordered, -> { order(:started_at) }

  def self.batch_update(ids, values)
    ActiveRecord::Base.transaction do
      Gig.update(ids, values)
    end
  end
end
