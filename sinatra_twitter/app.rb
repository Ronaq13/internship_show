require 'sinatra'
require 'data_mapper'

DataMapper.setup(:default, "sqlite:///#{Dir.pwd}/data.db")
set :public_folder, File.dirname(__FILE__) + '/static'
set :sessions, true

class User
    include DataMapper::Resource
    property :id, Serial
    property :email, String
    property :password, String
end

class Tweets
    include DataMapper::Resource
    property :id, Serial
    property :content, String
    property :user_id, Integer
    property :tweetTime, Time 
end

class Likes
    include DataMapper::Resource
    property :id, Serial
    property :user_id, Integer
    property :tweet_id, Integer
end

class Follow
    include DataMapper::Resource
    property :id, Serial
    property :user_email, String
    property :follower_email, String
    property :following_email, String
end

DataMapper.finalize
User.auto_upgrade!
Tweets.auto_upgrade!
Likes.auto_upgrade!
Follow.auto_upgrade!

get '/' do
    erb :home
end

get '/dashboard' do
    user = nil
    if session[:user_id]
        user = User.get(session[:user_id])  #class name '.' DataMapper method
    else
        redirect '/'
    end
    tweets = Tweets.all(:user_id => user.id)
    allTweets = Tweets.all()
    allUsers = User.all()
    allLikes = Likes.all()
    allFollow = Follow.all()
    erb :dashboard, locals: {user: user, tweets: tweets, allFollow: allFollow, allTweets: allTweets, allUsers: allUsers, allLikes: allLikes}     
end

get '/public' do
     user = nil
    if session[:user_id]
        user = User.get(session[:user_id])  #class name '.' DataMapper method
    else
        redirect '/'
    end
    tweets = Tweets.all(:user_id => user.id)
    allTweets = Tweets.all()
    allUsers = User.all()
    allLikes = Likes.all()
    allFollow = Follow.all()
    erb :public, locals: {user: user, tweets: tweets, allTweets: allTweets, allUsers: allUsers, allLikes: allLikes}     
   
end



get '/register' do
    erb :signUp
end

post '/register' do
    email = params[:email]
    password = params[:password]
    allUser = User.all()
    allUser.each do |user|
        if(user.email == email)
            redirect '/signUp'
        end
    end
    newUser = User.new
    newUser.email = email
    newUser.password = password
    newUser.save
    session[:user_id] = newUser.id
    redirect '/dashboard'
end

post '/signIn' do
    email = params[:email]
    password = params[:password]

    user = User.all(:email => email).first

    if user
        if user.password == password
            session[:user_email] = user.email
            session[:user_id] = user.id
            redirect '/dashboard'
        else
            redirect '/home'
        end
    else
        redirect '/signUp'
    end
end

get '/signUp' do
    erb :wrongEmail
end

get '/home' do
    erb :wrongPassword
end

post '/logout' do
	session[:user_id] = nil
	redirect '/'
end

post '/add_tweet' do
    content = params[:contentOfTweet]
    tweet = Tweets.new
    tweet.content = content
    tweet.tweetTime = Time.now
    tweet.user_id = session[:user_id]
    tweet.save
    session[:tweet_id] = tweet.id
    redirect '/dashboard'
end


post '/editTweet' do
    tweetObj = Tweets.get(params[:tweet_id])
    tweetId = tweetObj.id
    tweetContent = tweetObj.content
    tweetUserId = tweetObj.user_id
    erb :editTweet, locals: {tweetContent: tweetContent, tweetUserId: tweetUserId, tweetId: tweetId}
end

post '/afterEditingTweet' do
    tweetId = params[:tweetId]
    tweetObj = Tweets.get(tweetId)
    tweetObj.content = params[:contentChanged]
    tweetObj.save
    redirect '/dashboard'
end


post '/deleteTweet' do
    tweetObj = Tweets.get(params[:tweet_id])
    tweetObj.destroy
    redirect back
end













post '/likeButtonClicked' do
    like = Likes.new
    like.user_id = session[:user_id]
    like.tweet_id = params[:tweet_id]
    like.save
    redirect back
end

post '/dislikeButtonClicked' do
   tweetId = params[:tweet_id]
   tweetToBeDeleted = Likes.all(:tweet_id => tweetId).first
   tweetToBeDeleted.destroy
   redirect back
end

get '/userProfile' do
    userToSeeDetails = nil
    userToSeeDetails = User.get(session[:user_id])
    erb :userProfile, locals: {userToSeeDetails: userToSeeDetails}
end


post '/searchResult' do
    if session[:user_id]
        sessionUser = User.get(session[:user_id]) 
    end
    youSearchedFor = params[:youSearchedFor]
    allUsers = User.all()
    allFollow = Follow.all()
    erb :searchResult, locals: {sessionUser: sessionUser, youSearchedFor: youSearchedFor, allUsers: allUsers, allFollow: allFollow}
end

post '/doFollowing' do
    follow1 = Follow.new
    follow1.user_email = params[:userEmail]
    follow1.follower_email = params[:sessionUser]
    follow1.save
    follow2 = Follow.new
    follow2.user_email = params[:sessionUser]
    follow2.following_email = params[:userEmail]
    follow2.save
    redirect '/dashboard'
end

post '/doUnFollowing' do
    unFollowerEmail = params[:userEmail]
    followerEmail = params[:sessionUser]    # the person who clicked the unfollow button
    followList = Follow.all(:user_email => unFollowerEmail)
    followList.each do |follow|
        if(follow.follower_email == followerEmail)
            follow.destroy
        # elsif (followerEmail == follow.user_email)
        #         follow.destroy
        end
    end  

    followList2 = Follow.all(:user_email => followerEmail)
    followList2.each do |follow|
        if(follow.following_email == unFollowerEmail)
            follow.destroy
        end
    end
    redirect '/dashboard'  
end