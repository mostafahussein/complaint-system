module Modules
  module DefaultValues
    ROLE = [ADMIN = 'admin', MANAGER = 'head of department', STAFF = 'staff', ADVISOR = 'advisor', STUDENT = 'student']
    STATUS = [OPEN = 'open', PROGRESS = 'in progress', PENDING = 'pending', SOLVED = 'solved', CLOSED = 'closed']
    PRIORITY = [HIGH = 'high', NORMAL = 'normal', LOW = 'low']
    DEPARTMENT = [SWE = 'software engineering', STAD = 'student advisor']
    POSITION = [SWE_MANAGER = 'head of department', SWE_STAFF = 'staff', STAD_ADVISOR = 'advisor']
    USER_TYPE = [TYPEA = 'admin', TYPEB = 'employee', TYPEC = 'student']
    GENDER = [MALE = 'male', FEMALE = 'female']
    REASON = [MAJOR = 'required for major', MINOR = 'required for minor', ELECTIVE = 'elective']
    SATISFACTION = [S_VDIS = 'very dissatisfied', S_DIS = 'dissatisfied', S_NEU = 'neutral', SAT = 'satisfied', S_SAT = 'very satisfied']
    RATE = [R_SDIS = 'strongly disagree', R_DIS = 'disagree', R_NEU = 'neutral', AG = 'agree', R_AG = 'strongly agree']
    COLOR = [H_COLOR = '#FEE7E7', N_COLOR = '#FFFFF0', L_COLOR = '#DDFFDD']
    CATEGORY = [EXAM = 'exam' , MATERIAL = "subject material" , CLASSROOM = 'classroom' , INSTRUCTOR = "subject instructor"]
  end
end