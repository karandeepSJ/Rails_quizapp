class StatesController < ApplicationController
	def new
		sg=params[:subgenre]
		if logged_in?
			uid=current_user.id
			if State.find_by(user_id: uid, subgenre_id: sg)
				State.find_by(user_id: uid, subgenre_id: sg).delete
			end
			State.create(user_id: uid, subgenre_id: sg, q_no: 0, score: 0, slused: false, smused: false)
			@subgenre = Subgenre.find_by(id: params[:subgenre])
			@genre = @subgenre.genre
			render 'show'
		else
			redirect_to root_url
		end
	end

	def quiz
		@genre = Genre.find_by(id: params[:genre])
		@subgenre = Subgenre.find_by(id: params[:subgenre])
		s = State.find_by(user_id: current_user.id, subgenre_id: params[:subgenre])
		@question = s.q_no
		@question = @subgenre.questions[@question]
		if @question
			render :json => {
           	                 :q => @question,
           	                 :subg => @subgenre,
            	             :g => @genre,
            	             :score => s.score
                	        }
        else
        	c = Completed.find_by(user_id: current_user.id, subgenre_id: params[:subgenre])
        	if c
        		c.score = [c.score,s.score].max
        		c.save
        	else
        		Completed.create(user_id: current_user.id, subgenre_id: params[:subgenre], score: s.score, genre_id: params[:genre])
        	end
        	s.delete
        	render :js => "alert('Quiz Complete'); window.location = 'users/#{current_user.id}'"
        end
	end

	def checkans
		ans = Question.find(params[:ques]).answer
		s = State.find_by(user_id: current_user.id, subgenre_id: params[:sg])
		s.q_no+=1
		if ans==params[:answer]
			s.score+=100
			s.save
			render :json => {
                            :result => "Correct Answer :)"
                        }
		else
			s.score-=50
			s.save
			
			render :json => {
                            :result => "Wrong Answer :("
                        }
		end
	end

	def contquiz
		@subgenre = Subgenre.find_by(id: params[:sg])
		@genre = @subgenre.genre
		render 'show'
	end

	def leaderboard
		users=[]
		scores=[]
		if params[:subgenre] == "None"
			ret = Completed.order('score DESC').where(genre_id: params[:genre])
		else
			ret = Completed.order('score DESC').where(subgenre_id: params[:subgenre])
		end
		for i in ret
			scores.push(i.score)
			users.push(User.find_by(id: i.user_id).name)
		end
		render :json => {
			:users => users,
			:scores => scores
			}
	end

	def myquizzes
		compqs = Completed.where(user_id: current_user.id)
		compqids = []
		completed = []
		not_completed = []
		for i in compqs
			compqids.push(i.subgenre_id)
			completed.push({
				"genre" => Genre.find_by(id: i.genre_id).name,
				"subgenre" => Subgenre.find_by(id: i.subgenre_id).name,
				"score" => i.score
				})
		end
		notcompqs = Subgenre.where.not(id: compqids)
		for i in notcompqs
			not_completed.push({
				"genre" => i.genre.name,
				"subgenre" => i.name,
				"score" => "NA"
				})
		end
		render :json => {
			:completed => completed,
			:not_completed => not_completed
			}
	end

	def fifty
		s = State.find_by(user_id: current_user.id, subgenre_id: params[:subgenre])
		q = s.q_no;
		ques = Question.where(subgenre_id: params[:subgenre])[q];
		puts "SDFDS"
		puts !s.slused
		if ques.qtype == "Single Correct" and !s.slused
			ans = ques.answer
			oth = "1234".tr(ans,'')
			arr = oth.split('').map {|i| i.to_i}
			s.slused = true
			s.save
			render :json => {
			:allowed => true,
			:o => arr.sample(2)
			}
		else
			if ques.qtype == "Multiple Correct"
				message = "You are not allowed to use 50-50 for Multiple Correct Questions"
			else
				message = "You cannot use this lifeline again"
			end
			render :json => {
			:allowed => false,
			:message => message
			}
		end
	end

	def choose
		s = State.find_by(user_id: current_user.id, subgenre_id: params[:subgenre])
		q = s.q_no;
		ques = Question.where(subgenre_id: params[:subgenre])[q];
		if ques.qtype == "Multiple Correct" and !s.smused
			ans = ques.answer
			arr = ans.split('').map {|i| i.to_i}
			s.smused = true
			s.save
			render :json => {
			:allowed => true,
			:o => arr.sample(1)
			}
		else
			if ques.qtype == "Single Correct"
				message = "You are not allowed to use Choose 1 for Single Correct Questions"
			else
				message = "You cannot use this lifeline again"
			end
			render :json => {
			:allowed => false,
			:message => message
			}
		end
	end
end
