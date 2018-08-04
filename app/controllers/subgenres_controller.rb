class SubgenresController < ApplicationController
  def getsubgenres
    subg = Genre.find_by(id: params[:g]).subgenres
    render json: subg 
  end

  def ongoing
    g = []
    sg = []
    s = State.where(user_id: current_user.id)
    puts s
    puts "DFsfs"
    for i in s
      temp = Subgenre.find_by(id: i.subgenre_id)
      sg.push(temp)
      g.push(temp.genre)
    end
    render :json => {
                            :genres => g,
                            :subgenres => sg
                        }
  end 
end
