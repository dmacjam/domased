class EventRecommender
  include Predictor::Base

  limit_similarities_to 10
  
  input_matrix :users, weight: 5.0
	
  def recommender
	@recommender ||= EventRecommender.new
  end
end
