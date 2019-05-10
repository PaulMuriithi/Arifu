# Arifu
Shortcode: 22744
Text: Arifu

Response:
Message with options

### Components
- Frontend - SMS
- Shortcode gateway
- Load balancer
- App servers - Api
- Database cluster

### Flow:
- User sends the text "Arifu" to 22744
- Telco receives the text
- Telco forwards it to the Shortcode gateway who then forwards it to the load balancer or if the connection is direct then the Telco forwards it directly to the load balancer
- Load balancer checks to see which App server has the least load and forwards the request to it
- App server checks the text and gets the recent session from the user if any and if none, starts one
- The session is passed to a matching engine which matches queries to responses
- This could either be implemented as key(text) to value(response) pairs or it use some machine learning
- Once a response is formed, it is saved as part of the session data
- The App server then sends a text with the formatted response back to the users phone number using the session id 
- The Shortcode gateway then forwards the response to the user's device


### Api:
	Flask:
		- Flask-Restful - for the Api
		- SQLAlchemy - for Db access
		- Marshmallow for serializing api responses

	class LearningApi(Resource):
	    def __init__(self):
	        super(LearningApi, self).__init__()

	    def post(self):
	    	data = parse_and_validate_request()
	    	
	    	session = get_or_save_session(data)

	    	send_text(session.phone_number, process_query(session))

	    	return Response(status=200)

	    def parse_and_validate_request(self):
	    	# check all required fields are present


	    def get_or_save_session(self, data):
	    	session = Session.query.filter_by(session_id=data['session_id']).first()
	    	if session is None:
	    		# create a new session
	    		session = Session(...)
	    	return session

	    def process_query(self, session):
	    	# get the last hop for this session
	    	hop = Hop.query.filter_by(session_id=session.id).last()
	    	if hop is None:
	    		# return the default response perhaps

	    	return get_response_based_on_user_journey(session, hop)

	    def get_response_based_on_user_journey(session, hop):
	    	# depends on how the options available are structured
	    	# it could be a journey sort of
	    	

	    def send_text(self, phone_number, text):
	    	# send text to phone_number

	...
	api.add_resource(LearningApi, api_base_url + '/learn', endpoint='learn')



### Database:
	Could use PostgreSQl/MongoDb(to store sessions) + Redis(to store mappings to responses)
	At the simplest, the PostgreSQl schema would look something like:
		
		Users
			- id - maybe a uuid
			- phone_number
			- created_at


		Session
			- id
			- session_id - the one sent back and forth to the shortcode gateway
			- user_id - FK to Users.id
			- created_at

		Hops
			- id - maybe a uuid
			- session_id - FK to Sessions.id
			- query
			- response
			- created_at



