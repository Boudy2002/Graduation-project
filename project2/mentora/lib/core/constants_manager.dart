import 'package:mentora_app/core/assets_manager.dart';
import 'package:mentora_app/data/DM/question_dm.dart';
import 'package:mentora_app/data/DM/quiz_dm.dart';

class ConstantsManager {
  static List<String> risacAnswers = ["Agree", "Don't Agree"];
  static List<String> bigFiveAnswers = ["Strongly agree", "Slightly agree", "neutral", "Slightly disagree", "Strongly Disagree"];

  static List<QuestionDM> risacQuestions = [
    QuestionDM(
      question: "I like to work on cars",
      answers: risacAnswers,
      type: "Realistic",
    ),
    QuestionDM(
      question: "I like to do puzzles",
      answers: risacAnswers,
      type: "Investigative",
    ),
    QuestionDM(
      question: "I am good at working independently",
      answers: risacAnswers,
      type: "Artistic",
    ),
    QuestionDM(
      question: "I like to work in teams",
      answers: risacAnswers,
      type: "Social",
    ),
    QuestionDM(
      question: "I am an ambitious person, I set goals for myself",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to organize things (files, desks/offices)",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to build things",
      answers: risacAnswers,
      type: "Realistic",
    ),
    QuestionDM(
      question: "I like to read about art and music",
      answers: risacAnswers,
      type: "Artistic",
    ),
    QuestionDM(
      question: "I like to have clear instructions to follow",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to try to influence or persuade people",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to do experiments",
      answers: risacAnswers,
      type: "Investigative",
    ),
    QuestionDM(
      question: "I like to teach or train people",
      answers: risacAnswers,
      type: "Social",
    ),
    QuestionDM(
      question: "I like trying to help people solve their problems",
      answers: risacAnswers,
      type: "Social",
    ),
    QuestionDM(
      question: "I like to take care of animals",
      answers: risacAnswers,
      type: "Realistic",
    ),
    QuestionDM(
      question: "I wouldn't mind working 8 hours per day in an office",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like selling things",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I enjoy creative writing",
      answers: risacAnswers,
      type: "Artistic",
    ),
    QuestionDM(
      question: "I enjoy science",
      answers: risacAnswers,
      type: "Investigative",
    ),
    QuestionDM(
      question: "I am quick to take on new responsibilities",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I am interested in healing people",
      answers: risacAnswers,
      type: "Social",
    ),
    QuestionDM(
      question: "I enjoy trying to figure out how things work",
      answers: risacAnswers,
      type: "Investigative",
    ),
    QuestionDM(
      question: "I like putting things together or assembling things",
      answers: risacAnswers,
      type: "Realistic",
    ),
    QuestionDM(
      question: "I am a creative person",
      answers: risacAnswers,
      type: "Artistic",
    ),
    QuestionDM(
      question: "I pay attention to details",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to do filing or typing",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to analyze things (problems/situations)",
      answers: risacAnswers,
      type: "Investigative",
    ),
    QuestionDM(
      question: "I like to play instruments or sing",
      answers: risacAnswers,
      type: "Artistic",
    ),
    QuestionDM(
      question: "I enjoy learning about other cultures",
      answers: risacAnswers,
      type: "Social",
    ),
    QuestionDM(
      question: "I would like to start my own business",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to cook",
      answers: risacAnswers,
      type: "Realistic",
    ),
    QuestionDM(
      question: "I like acting in plays",
      answers: risacAnswers,
      type: "Artistic",
    ),
    QuestionDM(
      question: "I am a practical person",
      answers: risacAnswers,
      type: "Realistic",
    ),
    QuestionDM(
      question: "I like working with numbers or charts",
      answers: risacAnswers,
      type: "Investigative",
    ),
    QuestionDM(
      question: "I like to get into discussions about issues",
      answers: risacAnswers,
      type: "Social",
    ),
    QuestionDM(
      question: "I am good at keeping records of my work",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like to lead",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I like working outdoors",
      answers: risacAnswers,
      type: "Realistic",
    ),
    QuestionDM(
      question: "I would like to work in an office",
      answers: risacAnswers,
      type: "Enterprising",
    ),
    QuestionDM(
      question: "I'm good at math",
      answers: risacAnswers,
      type: "Investigative",
    ),
    QuestionDM(
      question: "I like helping people",
      answers: risacAnswers,
      type: "Social",
    ),
    QuestionDM(
      question: "I like to draw",
      answers: risacAnswers,
      type: "Artistic",
    ),
    QuestionDM(
      question: "I like to give speeches",
      answers: risacAnswers,
      type: "Enterprising",
    ),
  ];

  // for big five and risac
  // add type in each question ==> done
  // create map<string, int> strongly agree 5, ...
  // in first question is strongly agree add in counter of type of this question
  // number of totally agree of types, then take counter of type calculated and calculate percentage of this type


  static List<QuestionDM> bigFiveQuestions = [
    QuestionDM(
      question: "I Am the life of the party.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Feel little concern for others.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Am always prepared.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Get stressed out easily.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Have a rich vocabulary.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Don't talk a lot.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Am interested in people.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Leave my belongings around.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Am relaxed most of the time.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Have difficulty understanding abstract ideas.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Feel comfortable around people.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Insult people.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Pay attention to details.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Worry about things.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Have a vivid imagination.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Keep in the background.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Sympathize with others' feelings.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Make a mess of things.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Seldom feel blue.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Am not interested in abstract ideas.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Start conversations.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Am not interested in other people's problems.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Get chores done right away.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Am easily disturbed.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Have excellent ideas.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Have little to say.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Have a soft heart.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Often forget to put things back in their proper place.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Get upset easily.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Do not have a good imagination.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Talk to a lot of different people at parties.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Am not really interested in others.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Like order.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Change my mood a lot.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Am quick to understand things.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Don't like to draw attention to myself.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Take time out for others.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Shirk my duties.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Have frequent mood swings.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Use difficult words.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Don't mind being the center of attention.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Feel others' emotions.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Follow a schedule.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Get irritated easily.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Spend time reflecting on things.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
    QuestionDM(
      question: "I Am quiet around strangers.",
      answers: bigFiveAnswers,
      type: "Extroversion",
    ),
    QuestionDM(
      question: "I Make people feel at ease.",
      answers: bigFiveAnswers,
      type: "Agreeableness",
    ),
    QuestionDM(
      question: "I Am exacting in my work.",
      answers: bigFiveAnswers,
      type: "Conscientiousness",
    ),
    QuestionDM(
      question: "I Often feel blue.",
      answers: bigFiveAnswers,
      type: "Neuroticism",
    ),
    QuestionDM(
      question: "I Am full of ideas.",
      answers: bigFiveAnswers,
      type: "Openness to Experience",
    ),
  ];

  static List<QuestionDM> criticalThinkingQuestions = [
    QuestionDM(
        question: "Do they have a 4th of July in England?",
        answers: ["Yes", "No", "Maybe", "I don't know"],
        correctAnswer: "Yes"
    ),
    QuestionDM(
        question: "How many birthdays does the average man have?",
        answers: ["One", "365", "Depends on his age", "Twelve"],
        correctAnswer: "One"
    ),
    QuestionDM(
        question: "Some months have 31 days, how many have 28?",
        answers: ["One", "All of them", "Two", "Depends on the year"],
        correctAnswer: "All of them"
    ),
    QuestionDM(
        question: "A woman gives a beggar 50 cents, the woman is the beggar's sister, but the beggar is not the woman's brother. How come?",
        answers: ["The beggar is her sister", "It's a riddle", "The beggar is adopted", "He is her cousin"],
        correctAnswer: "The beggar is her sister"
    ),
    QuestionDM(
        question: "Why can't a man living in the USA be buried in Canada?",
        answers: ["Because it's illegal", "Because he's not Canadian", "Because he's still alive", "Because he doesn’t want to be"],
        correctAnswer: "Because he's still alive"
    ),
    QuestionDM(
        question: "How many outs are there in an inning?",
        answers: ["6", "3", "9", "2"],
        correctAnswer: "6"
    ),
    QuestionDM(
        question: "Is it legal for a man in California to marry his widow's sister?",
        answers: ["Yes", "No", "Only with permission", "Only if she agrees"],
        correctAnswer: "No"
    ),
    QuestionDM(
        question: "Two women play five games of checkers. Each woman wins the same number of games. There are no ties. Explain this.",
        answers: ["They cheated", "They played with someone else", "They weren’t playing each other", "They played online"],
        correctAnswer: "They weren’t playing each other"
    ),
    QuestionDM(
        question: "Divide 30 by 1/2 and add 10. What is the answer?",
        answers: ["25", "70", "30", "50"],
        correctAnswer: "70"
    ),
    QuestionDM(
        question: "A man builds a house rectangular in shape. All sides have southern exposure. A bear walks by the house. What color is the bear? Why?",
        answers: ["White, it's a polar bear", "Black, it's in the forest", "Brown, it's common", "Depends on the location"],
        correctAnswer: "White, it's a polar bear"
    ),
    QuestionDM(
        question: "There are 3 apples and you take away 2. How many do you have?",
        answers: ["1", "2", "3", "None"],
        correctAnswer: "2"
    ),
    QuestionDM(
        question: "I have two U.S. coins totaling 55 cents. One is not a nickel. What are the coins?",
        answers: ["50c and a nickel", "A half-dollar and a nickel", "A penny and a half-dollar", "Two quarters and a nickel"],
        correctAnswer: "A half-dollar and a nickel"
    ),
    QuestionDM(
        question: "If you have only one match and you walked into a room where there was an oil burner, a kerosene lamp, and a wood-burning stove, what would you light first?",
        answers: ["Lamp", "Oil burner", "Stove", "The match"],
        correctAnswer: "The match"
    ),
    QuestionDM(
        question: "How far can a forester run into the woods?",
        answers: ["Halfway", "Until he gets tired", "All the way", "One mile"],
        correctAnswer: "Halfway"
    ),
    QuestionDM(
        question: "What was the president's name in 1950?",
        answers: ["Biden", "Bush", "Same as now", "Obama"],
        correctAnswer: "Same as now"
    ),
    QuestionDM(
        question: "A forester has 17 trees, and all but 9 die. How many are left?",
        answers: ["9", "8", "0", "All"],
        correctAnswer: "9"
    ),
    QuestionDM(
        question: "How many 2-cent stamps are in a dozen?",
        answers: ["6", "12", "24", "1"],
        correctAnswer: "12"
    ),
    QuestionDM(
        question: "A 4 x 4 planting density per acre is twice as many trees as an 8 x 8 spacing.",
        answers: ["True", "False", "Depends on species", "Only in tropical regions"],
        correctAnswer: "True"
    ),
    QuestionDM(
        question: "Name the greatest of all inventors.",
        answers: ["Einstein", "Edison", "Imagination", "Tesla"],
        correctAnswer: "Imagination"
    ),
    QuestionDM(
        question: "Are creative skill practice books for children for the enrichment of their creative thinking?",
        answers: ["Yes", "No", "Depends on the child", "Sometimes"],
        correctAnswer: "Yes"
    ),
  ];
  static List<QuestionDM> problemSolvingQuestions = [
    QuestionDM(
      question: "A child’s jacket is being made. It will need 3 buttonholes all evenly spaced. The distance from the bottom of the jacket to the top buttonhole will be 12 cm. What will be the distance between each buttonhole if there is a 2 cm space at the bottom?",
      answers: ["5 cm", "6 cm", "4 cm", "3 cm"],
      correctAnswer: "5 cm",
    ),
    QuestionDM(
      question: "You are going out for a meal with a friend. The time is 5pm and you have to meet her at 8pm. How long is it until you need to meet her?",
      answers: ["2 hours", "3 hours", "4 hours", "1 hour"],
      correctAnswer: "3 hours",
    ),
    QuestionDM(
      question: "There are 27 people waiting for a coach. When the coach arrives it only has room for 15 people. How many people will have to wait for the next coach?",
      answers: ["12", "10", "15", "20"],
      correctAnswer: "12",
    ),
    QuestionDM(
      question: "At a shopping centre you buy a skirt which costs £17.00 and a top which costs £8. How much do you spend in total?",
      answers: ["£25.00", "£24.00", "£26.00", "£23.00"],
      correctAnswer: "£25.00",
    ),
    QuestionDM(
      question: "A swimming pool is 10 metres in width. If you swim across and back twice, how far will you swim?",
      answers: ["40m", "20m", "10m", "50m"],
      correctAnswer: "40m",
    ),
    QuestionDM(
      question: "A furniture shop has had a delivery of tables and a delivery of chairs. There are 3 tables and 18 chairs. How many chairs should be matched with each table?",
      answers: ["6", "3", "9", "5"],
      correctAnswer: "6",
    ),
    QuestionDM(
      question: "A car park has spaces for 75 cars but 110 turn up on a Saturday morning. How many cars cannot get into the car park?",
      answers: ["35", "25", "30", "40"],
      correctAnswer: "35",
    ),
    QuestionDM(
      question: "You go to a fast food outlet and order a burger at £2.80 and a tea at £1.20. How much do you pay?",
      answers: ["£4.00", "£3.50", "£3.90", "£4.20"],
      correctAnswer: "£4.00",
    ),
    QuestionDM(
      question: "A gardener needs three lengths of fencing for a garden. He needs 2 lengths measuring 10 metres and one length measuring 5 metres. How much does he need altogether?",
      answers: ["25 metres", "20 metres", "15 metres", "30 metres"],
      correctAnswer: "25 metres",
    ),
    QuestionDM(
      question: "You need 100 tiles to tile your bathroom wall. The tiles are sold in boxes of 5. How many boxes will you need to buy?",
      answers: ["20", "25", "10", "15"],
      correctAnswer: "20",
    ),
    QuestionDM(
      question: "6 flatmates go to the supermarket. They decide to divide the cost up between them. If they pay £36 in total, how much will each flatmate have to pay?",
      answers: ["£6", "£7", "£5", "£8"],
      correctAnswer: "£6",
    ),
    QuestionDM(
      question: "A tree is 3 metres tall and is growing 25 cm each year, how high will it be in 3 years?",
      answers: ["3.75m", "4.25m", "3.50m", "4.00m"],
      correctAnswer: "3.75m",
    ),
    QuestionDM(
      question: "The price of some fruit is 50% more expensive in winter than in summer. If strawberries cost £1.60 for a punnet in summer, how much would they cost in winter?",
      answers: ["£2.40", "£2.00", "£1.90", "£2.20"],
      correctAnswer: "£2.40",
    ),
    QuestionDM(
      question: "You are on a bus in slow-moving traffic. The average speed of the bus is 10 mph. How long will it take to travel 5 miles?",
      answers: ["30 minutes", "15 minutes", "1 hour", "45 minutes"],
      correctAnswer: "30 minutes",
    ),
    QuestionDM(
      question: "You need 100 tiles to cover a wall. The tiles are sold in boxes of 9. How many boxes will you need to buy?",
      answers: ["12", "11", "10", "9"],
      correctAnswer: "12",
    ),
    QuestionDM(
      question: "The temperature in London is 5°C, while in Oslo it is -3°C. What is the difference in temperature?",
      answers: ["8°C", "5°C", "3°C", "10°C"],
      correctAnswer: "8°C",
    ),
    QuestionDM(
      question: "A cyclist goes 14 miles to work each morning and the same back in the evening. How many miles will the cyclist do to work and back each day?",
      answers: ["28", "14", "20", "24"],
      correctAnswer: "28",
    ),
    QuestionDM(
      question: "You have an 8-hour DVD and need to know how many 50-minute programmes you can record, and how much space will be left over.",
      answers: ["9 programs, 30 mins left", "10 programs, 0 mins left", "8 programs, 40 mins left", "9 programs, 60 mins left"],
      correctAnswer: "9 programs, 30 mins left",
    ),
    QuestionDM(
      question: "Your friend is training for a 10-mile run. She aims to do training runs of 30 miles a week. If she trains for 5 days a week and runs the same distance each day, how many miles will she run each day?",
      answers: ["6", "5", "7", "4"],
      correctAnswer: "6",
    ),
    QuestionDM(
      question: "A club trip has been organised. If 4 people are travelling together in a car, how many cars will be needed for 25 people?",
      answers: ["7", "6", "5", "8"],
      correctAnswer: "7",
    ),
    QuestionDM(
      question: "An exercise machine costs £120 by mail order. If it can be paid for in 12 equal instalments, what will be the amount of each instalment?",
      answers: ["£10", "£12", "£15", "£8"],
      correctAnswer: "£10",
    ),
    QuestionDM(
      question: "A shop buys DVDs for £5 each. It sells them at £11 each, or 3 for £24. How much profit would they make on selling 2 DVDs?",
      answers: ["£12", "£10", "£8", "£6"],
      correctAnswer: "£12",
    ),
    QuestionDM(
      question: "A car park has 1,000 spaces. When the car park is three-quarters full, how many spaces will still be free?",
      answers: ["250", "500", "200", "300"],
      correctAnswer: "250",
    ),
    QuestionDM(
      question: "You pay £1.80 for a 2-litre bottle of cola. What is the cost per litre?",
      answers: ["£0.90", "£0.80", "£1.00", "£1.20"],
      correctAnswer: "£0.90",
    ),
    QuestionDM(
      question: "In a survey of 600 people, 25% said they could swim less than 100 m. The remainder said that they could swim 100 m or further. How many people said they could swim 100 m or further?",
      answers: ["450", "500", "400", "300"],
      correctAnswer: "450",
    ),
    QuestionDM(
      question: "In a quiz, you score 5 for a correct answer and -2 for a wrong answer. What would be the score for 8 correct and 4 wrong?",
      answers: ["28", "30", "36", "20"],
      correctAnswer: "28",
    ),
    QuestionDM(
      question: "A man won £6,000 in a competition. When he went to collect his prize money, hotel and travel expenses came to £250. He also spent a further £500 on celebrating. How much of his prize money was left?",
      answers: ["£5,250", "£5,500", "£5,750", "£5,000"],
      correctAnswer: "£5,250",
    ),
    QuestionDM(
      question: "Have a look at the prices for car parking shown below. Up to 1 hour is 90p, 1 to 2 hours is £1.50, 2 to 3 hours is £2.30. Your friend parks at 14:15. She only has £2 in cash. When will she have to leave the car park?",
      answers: ["By 16:15", "By 16:00", "By 15:15", "By 15:45"],
      correctAnswer: "By 16:15",
    ),
    QuestionDM(
      question: "A friend wants to buy a music system. There are two ways of paying: £399 cash or £95 deposit then payments totalling £350. What is the difference in price?",
      answers: ["£46", "£50", "£56", "£60"],
      correctAnswer: "£46",
    ),
    QuestionDM(
      question: "The ingredients for 40 small buns include 400g butter and 160g of cherries. What amount of each would you need for 10 small buns?",
      answers: ["100g butter, 40g cherries", "80g butter, 32g cherries", "120g butter, 50g cherries", "90g butter, 36g cherries"],
      correctAnswer: "100g butter, 40g cherries",
    ),
  ];

  static List<QuizDM> questionsDetails = [
    QuizDM(
      quizName: "RIASEC TEST",
      questionNumber: risacQuestions.length,
      quizTime: risacQuestions.length,
      rating: 4.8,
      imagePath: AssetsManager.riasec,
      questions: risacQuestions,
      pointsForEachQuestion: 10,
      totalPoints: 420,
      winStars: 50,
      index: 0,
    ),
     QuizDM(
      quizName: "Big Five Assessment",
      questionNumber: bigFiveQuestions.length,
      quizTime: bigFiveQuestions.length,
      rating: 4.7,
      imagePath: AssetsManager.bigFive,
      questions: bigFiveQuestions,
      pointsForEachQuestion: 10,
      totalPoints: 500,
      winStars: 75,
      index: 1,
     ),
    QuizDM(
      quizName: "Critical Thinking Assessment",
      questionNumber: criticalThinkingQuestions.length,
      quizTime: criticalThinkingQuestions.length*2,
      rating: 4.9,
      imagePath: AssetsManager.criticalThinking,
      questions: criticalThinkingQuestions,
      pointsForEachQuestion: 20,
      totalPoints: 400,
      winStars: 100,
      index: 2
    ),
    QuizDM(
      quizName: "Problem Solving Assessment",
      questionNumber: problemSolvingQuestions.length,
      quizTime: problemSolvingQuestions.length*2,
      rating: 4.9,
      imagePath: AssetsManager.problemSolving,
      questions: problemSolvingQuestions,
      pointsForEachQuestion: 20,
      totalPoints: 400,
      winStars: 100,
      index: 3
    ),
  ];
}
//
// void main(){
//   QuestionDM risca = ConstantsManager.questions["RIASEC TEST"]!.questions[0];
//
// }