module Modules
  module DefaultValues
    ROLE = [ADMIN = 'admin', MANAGER = 'head of department', STAFF = 'staff', ADVISOR = 'advisor', STUDENT = 'student']
    STATUS = [OPEN = 'open', PROGRESS = 'in progress', PENDING = 'pending', SOLVED = 'solved', CLOSED = 'closed']
    PRIORITY = [HIGH = 'high', NORMAL = 'normal', LOW = 'low']
    DEPARTMENT = [SWE = 'software engineering', STAD = 'student advisor']
    POSITION = [SWE_MANAGER = 'head of department', SWE_STAFF = 'staff', STAD_ADVISOR = 'advisor']
    USER_TYPE = [TYPEA = 'admin', TYPEB = 'employee', TYPEC = 'student']
    GENDER = [MALE = 'male', FEMALE = 'female']
    COLOR = [H_COLOR = '#FEE7E7', N_COLOR = '#FFFFF0', L_COLOR = '#DDFFDD']
    CATEGORY = [EXAM = 'exam' , MATERIAL = "subject material" , CLASSROOM = 'classroom' , INSTRUCTOR = "subject instructor", OTHER = 'others']
    QUEST_TYPE = [RADIO = 'Multiple Choice', CHECK = 'Checkboxes', BOX = 'Text', AREA = 'Pragraph Text', LIST = 'Choose From A List', GRID = 'Grid']
  end
end