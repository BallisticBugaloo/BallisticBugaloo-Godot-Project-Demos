extends Node

var quotes = [
	"What are you so hesitant about? It's your dream, isn't it? It's right in front of you, and you're wavering? You gotta be reckless and take whatever you can!",
	"If you don't take risks, you can't create a future.",
	"Push through the pain. Giving up hurts more.",
	"The strong should aid and protect the weak. Then, the weak will become strong, and they in turn will aid and protect those weaker than them. That is the law of nature.",
	"Hard work is worthless for those that don't believe in themselves.",
	"The important thing is not how long you live. It's what you accomplish with your life.",
	"It's quiet, but can you hear it? Little by little, the tides are changing, and the world with them.",
	"Nothing's perfect, the world's not perfect, but it's there for us, trying the best it can. That's what makes it so damn beautiful.",
	"If you never listen to anyone, you can't give proper advice.",
	"Sometimes you need a little wishful thinking to keep on living",
	"I guess, as long as I have life, all I can do is fight with all my might.",
	"When you give up, that's when the game ends.",
	"You see, sometimes friends have to go away, but a part of them stays behind with you.",
	"Sometimes, we have to look beyond what we want and do what's best.",
	"All things change in a dynamic environment. Your effort to remain what you are is what limits you.",
	"It's not dying that frightens us. It's living without ever having done our best.",
	"You're gonna care what other people think and be someone you're not your whole life? You're fine as you are. So, talk in your own words.",
	"There are certain things one can't bear without changing one's clothes.",
	"You will never be able to love anybody else until you love yourself.",
	"When you hit the point of no return, that's the moment it truly becomes a journey. If you can still turn back, it's not really a journey.",
	"Dead people receive more flowers than living ones because regret is stronger than gratitude.",
	"Life is short, so it will be appreciated. We live to our fullest due to that.",
	"Searching for someone to blame is such a pain.",
	"No matter how many weapons you have, no matter how great your technology might be, the world cannot live without love.",
	"Helping other people is the best way to make up for your mistakes",
	"To the left of that decimal, I need seven figures to play the joint Turn up your decibels, peep how I decimate a joint Check out my projects like them workers that Section 8 appoints And you'll see how I flipped, like exclamation points",
	"Eureka, Einstein on the brink of the theory of relativity, really no MC equal, feel me?",
	"I be stayin' out the way, but if the beef do come around Could put a M right on your head, you Luigi brother now.",
	"Envy keep yo pockets empty, so just focus on you If you broke and clownin a millionaire, the joke is on you.",
	"Some broken up too quick to call it My last scrap was with Puff Daddy, who woulda thought it.",
	"Call my bluff and I'll release everything I got  including the voicemails before you blew your top when me and Luis were tryin' to stick two CDs in the same slot.",
	"Now who's the King of these rude, ludicrous, lucrative lyrics who could inherit the title, put the youth in hysterics.",
	"True I got more fans than the average man but not enough loot to last me to the end of the week I live by the beat like you live check to check If you don't move your feet then I don't eat so we like neck to neck.",
	"My thoughts are sporadic I act like I'm an addict I rap like I'm addicted to smack like I'm Kim Mathers But I don't wanna go forth and back in constant battles The fact is I would rather sit back and bomb some rappers.",
	"I don't really think that the fact that I'm Slim matters a plaque and platinum status is wack if I'm not the baddest.",
	"I got a list, here's the order of my list that it's in It goes: Reggie, JAY-Z, 2Pac and Biggie Andre from OutKast, Jada, Kurupt, Nas, and then me But in this industry I'm the cause of a lot of envy So when I'm not put on this list, the shit does not offend me",
	"This may be a unique piece of advice, but I think its really helpful. Before you start writing code, if you haven't looked at math in a while, I would revisit the concepts from Algebra 1. Most of programming is built on algebra 1 math -- i.e., functions and variables.",
	"Break down problems into smaller ones",
	"A lot of times it is beneficial to write down in detail what you are trying to do in plain words before even trying to write code. This process is called pseudocoding, and it can take whatever form you want it to. It can also be helpful to solve a problem really slowly on paper first, thinking about or even writing down the individual steps you are taking to solve that problem.",
	"Knowledge does not go in vain! It's true that you should practice programming and coding on your own but reading codes by other people is very helpful. People make the common mistake of not reading programs done by someone else as they think that it is something wrong, but it's not true. Reading new things allows you to find solutions to problems that you found tough or were not able to do after many attempts. Doing this helps you to find the solution faster and save a lot of time.",
	"Programming is hard, and finding the right answer won't be immediate. One of the most pivotal moments in my programming journey was failing at writing a Sudoku solver. It can be challenging to adjust to not getting everything right away and seeing those error messages, but that is a huge part of programming.",
	"A lot of beginners don't pay attention to the errors given on the screen and ask for help from their mentors or senior programmers immediately. Understand that errors on the screen say a lot about the issues and you can find the solution from there as well if you read the error message carefully. Not from all the errors you can find the solution but before asking for help pay attention to it. If you don't get the solution, just search on the internet for the error message."
] 

var quote_index:int = 0
var previous_index:int = quote_index
var quote:String

func get_prompt() -> String:
    randomize()
    quote_index = randi() % quotes.size()
    while quote_index == previous_index:
        quote_index = randi() % quotes.size()
    previous_index = quote_index
    quote = quotes[quote_index]
    return quote
