final List<Map<String, dynamic>> Symptom_information = [
  {
    'title': 'IPSS',
    'descript': 'International Prostate Symptom Score',
    'time': '2 min',
    'qustion_count': '8 questions',
    'content':
        'This test is devised to help men determine how bothersome their symptoms are and check how effective their treatment is.\n\nTake the following 8-question quiz  and get a personalized urinary health score.'
  },
  {
    'title': 'OABSS',
    'descript': 'OverActive Bladder Symptom Score',
    'time': '1 min',
    'qustion_count': '4 questions',
    'content':
        'This test quantifies four bladder symptoms such as frequency of day and night bathroom trips, urgency and incontinence. It is recommended for people taking  bladder medication to assess treatment efficacy.'
  },
];

final List<Map<String, dynamic>> IPSS_Q = [
  {
    'num': 1,
    'title': 'Incomplete emptying',
    'content':
        'Over the past month, how often have you had a sensation of not emptying your bladder completely after you finish urinating?',
    'answer': ANSWER_1
  },
  {
    'num': 2,
    'title': 'Frequency',
    'content':
        'Over the past month, how often have you had to urinate again less than two hours after you finished urinating?',
    'answer': ANSWER_1
  },
  {
    'num': 3,
    'title': 'Intermittency',
    'content':
        'Over the past month, how often have you found you stopped and started again several times when you urinated?',
    'answer': ANSWER_1
  },
  {
    'num': 4,
    'title': 'Urgency',
    'content':
        'Over the last month, how difficult have you found it to postpone urination?',
    'answer': ANSWER_1
  },
  {
    'num': 5,
    'title': 'Weak stream',
    'content':
        'Over the past month, how often have you had a weak urinary stream?',
    'answer': ANSWER_1
  },
  {
    'num': 6,
    'title': 'Straining',
    'content':
        'Over the past month, how often have you had to push or strain to begin urination?',
    'answer': ANSWER_1
  },
  {
    'num': 7,
    'title': 'Nocturia',
    'content':
        'Over the past month, how many times did you most typically get up to urinate from the time you went to bed until the time you got up in the morning?',
    'answer': ANSWER_1
  },
  {
    'num': 8,
    'title': 'Quality of life due to urinary symptoms',
    'content':
        'If you were to spend the rest of your life with your urinary condition just the way it is now, how would you feel about that?',
    'answer': ANSWER_1
  },
];

final List<Map<String, dynamic>> OABSS_Q = [
  {
    'num': 1,
    'title': '01',
    'content':
        'How many times do you tipically urinate from waking in the morning until sleeping at night?',
    'answer': ANSWER_2
  },
  {
    'num': 2,
    'title': '02',
    'content':
        'How many times do you typically wake up to urinate from sleeping at night until waking in the morning?',
    'answer': ANSWER_3
  },
  {
    'num': 3,
    'title': '03',
    'content':
        'How often do have a sudden desire to urinate, which is difficult to defer? ',
    'answer': ANSWER_1
  },
  {
    'num': 4,
    'title': '04',
    'content':
        'How often do you leak urine because you cannot defer the sudden desire to urinate?',
    'answer': ANSWER_1
  },
];

final List<Map<String, dynamic>> ANSWER_1 = [
  {'num': 1, 'content': 'Not at all'},
  {'num': 2, 'content': 'Less than 1 in 5 Times'},
  {'num': 3, 'content': 'About Half the Time'},
  {'num': 4, 'content': 'More than Half the Time'},
  {'num': 5, 'content': 'Almost Always'}
];

final List<Map<String, dynamic>> ANSWER_2 = [
  {'num': 1, 'content': 'Less than 8'},
  {'num': 2, 'content': '8 ~ 14'},
  {'num': 3, 'content': 'Greater than 14'},
];

final List<Map<String, dynamic>> ANSWER_3 = [
  {'num': 1, 'content': '0'},
  {'num': 2, 'content': '1'},
  {'num': 3, 'content': '2'},
  {'num': 4, 'content': 'Greater than 2'}
];
