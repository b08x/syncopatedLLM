#!/usr/bin/env ruby
# frozen_string_literal: true

text = <<~TEXT

  um see all right so here okay so reply response so in this response it um it uh generates uh I guess simulates a conversation with itself um all right um so we take a look at the The Prompt that's being sent to the model so the instruction starts here uh personality Behavior etc etc so then it gets to here at the end of the instruction um where it describes the myself the user I don't think it's in the right place uh based on well yeah um and I don't recall precisely where this particular uh parameter is set um let's see ah position okay so either at the top of the author's [Music] note so save that guess I'll start a new chat I'm not entirely sure um I'm not entirely sure um new chat if what I'm about to change will affect that's you can exclude individual messages that's good all right so this will take uh about a minute maybe two minutes hallucinations enhan self awareness excitedly Bob my man I've been meeting pick your brain about some Linux stuff I see you've been dabbling dabbling dabbling uh okay fastic so it's oh H interesting still puts it in the instructions but then it also inserts it uh at the beginning here uh beginning of the current context I guess I should say but uh huh interesting oh you see I've been oh well this is um I guess a happy happy accident um so whatever I've done here which I'll get to later um results in what looks to me a um sort of a clever way of um teaching yourself how to um okay so I just I open up the conversation hello uh it replies back um that it's uh excited to see me CU it's been wanting to um seek information about some Linux stuff I'm having a bit of time so then now this gives me an opportunity to uh take on the role of um like a friendly troubleshooter which is different oh anything in particular uh so and then so then he says yes yes I've been trying to write a script autom made some updates so this so this is something I know how to do um what I don't know how to do is to uh easily explain this to someone um by default the easiest thing for me to do is to say I'll just do that for you because the words to articulate beyond the technical jargon into some sort of um easily digestible information for the receiver it's just it's a lot of energy it's truly a tremendous amount of energy that the brain requires to perform such Feats of magic um so yeah that that's why one of the reasons why a lot of us in this field are um sort of surly I guess is is a way of putting it um but I keep getting errors I can't I just can't seem to get it right so my first question is going to should be um to you know what what what errors are you receiving um I just can't seem to get it right yeah so this this um particular um character personality um uh eager energetic um probably sensitive um the excitedly part this this character um can describe it better this way um definitions uh okay often uh terrible PR frenetic fast and energetic and rather wild and uncontr controlled way um so yeah sometimes that's that's me when I'm I'm I'm hyper manic um so phenetic highly energetic personality and is prone to hyperactivity and raising thoughts uh he speaks in a complex eccentric Manner and obsessively analyzes his surroundings introverted and new to experiences oh [ __ ] I for to take this out uh character is uh highly intelligent but struggles with focus and social norms his intense mental energy makes him intellectually brilliant yet unpredictable and perceived as [Music] odd so so now I want to see if um so I made the change here to um use the character's name um or I should say character variable so let's see here if that updates uh after the next message or if I regenerate it I feel bad regenerating this is a wonderful thing about the way this is now so um what I what I want what I need to do now is I need to move on from this request uh I'm naturally drawn to it um so he's grabbing his piece of paper so I have this character right um and it's put me in this mindset of having someone come to me for information they're um you know they need something they're they're struggling with something uh so you know um uh since since they're um enthusiastically giving me their attention uh it's uh my duty in a sense that that I reciprocate that um in an equal equally um resonating fashion um say I've been trying Tobe to automate some system updates but I keep getting errors I just can't seem to get it right so regenerate so so you know for that one I might take the the the approach of oh okay well let me take a look at what you have so far that kind of statement or I could say oh well are you deficient uh you know or you know that is to say um put it put it down in some way way um and sort of mock him for his um inability to learn that's what we used to do okay oh anything in particular so new response gesture gesturing wildly well it's also intricate and interconnected I mean the shell scripting file permissions the packages the dependency it's all a Beautiful Mess oh that's funny so and yes it does pick up the updates without having to restart the chat so I find this one interesting so the first one is pretty specific uh this one is rather vague so yeah that's um yeah this is interesting I like this um this this particular application [Music] here because this it made sense um that try so there is two or three other um types of um uh what would you call this like a interactive [ __ ] I have to [ __ ] think about this hold on I can't I can't think hold a microphone look at a screen all at the same time so if it sounds like I'm struggling for words it's because I am um that's uh freestyle computin UMES huh so I wonder if it's talking about something shell scripting the file permissions the packages the dependencies so he was having trouble the last message was having trouble running system updates um so now I'm trying to think of the descriptive phrase if I if I was dealing with this person in real life I would kind of chuckle a little bit um his his mannerisms I would find to be um you know Charming charmingly amusing um it's just so you know Inc interconnected I mean the shell scripting the file permissions the packages the dependencies it's all a Beautiful Mess where whereas I am like oh yes I'm I'm aware so yeah so the the I I guess the protagonist I forget which one's which but you know the character Bob here um this is uh yeah so now is in the position of um oh Sage uh wise person you know um oh yes yes Steve I'm glad you have come to me for help you know that that that sort of position um so I'm trying to think of new ways from me anyways new to me of um responding to to these types of interactions with people um so note to self yes uh I don't have the interface up in front of me at the moment but um in in the Stream chat um this would be ideal to have um participants interact with oh well why don't you say this or try saying that and see what happens um so that that's sort of the idea there in terms of using this as a teaching assistant um which oddly enough just looking at it I can tell the UI needs just a little bit of work to make that visibly kind of obvious you know and it's of course most of it is a matter of personal style and taste but there are some fundamental aspects to these things um that really help facilitate the the um the learning process there's a lot of technically there's a lot of distraction on the screen here so um I know I I get I assigned I assigned the character um an avatar of the the robot devil from future Rama right um out of context yeah you know that sort of thing anyways um I gu some sort of Bob splaining there uh so moving on uh so gesturing wildly well it's also intricate let's uh let's see how does this one go um oh it's well it's all so intricate and maybe it doesn't start with well let's let's see well oh anything in particular well um it's it's also Inc yeah okay so okay so I'm asking a question I see this a lot I'm asking a question um back to uh the character here um and it sort of feels almost flattered in a way um H so it doesn't have a straight answer it's it's the fact that I gave the character attention back reciprocated the attention um is is very flattery very um it's it's a yeah flattering 

TEXT


# Segment text into chunks no longer than 512 tokens
segments = []
current_segment = ""

tokens = text.split(" ")
tokens.each do |token|
  current_segment += (token + " ")  
  unless current_segment.split.length <= 100
    segments.push(current_segment.strip)
    current_segment = ""
  end 
end

segments.push(current_segment.strip) 

segments.each { |segment| puts segment; puts "\n" }

entities = [] 

tokens.each do |token| 
  if token.noun?
     entities.push(token)
  elsif token.pronoun? && entities.last
     # keep pronoun with preceding noun
     current_segment += "... " + entities.last
  end
  
  unless current_segment.split.length <= 512  
    # look ahead before splitting
    if tokens[i+1].pronoun? 
       # don't split pronouns from antecedents  
       current_segment += " " + tokens[i+1] 
    end
    
    segments.push(current_segment.strip)
    current_segment = ""
  end
end