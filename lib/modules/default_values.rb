module Modules
  module DefaultValues
    ROLE = [ADMIN = 'admin', MANAGER = 'head of department', STAFF = 'staff', ADVISOR = 'advisor', STUDENT = 'student']
    STATUS = [OPEN = 'open', PROGRESS = 'in progress', PENDING = 'pending', SOLVED = 'solved', CLOSED = 'closed']
    PRIORITY = [HIGH = 'high', NORMAL = 'normal', LOW = 'low']
    DEPARTMENT = [SWE = 'software engineering', STAD = 'student advisor']
    POSITION = [SWE_MANAGER = 'head of department', SWE_STAFF = 'staff', STAD_ADVISOR = 'advisor']
    USER_TYPE = [TYPEA = 'admin', TYPEB = 'employee', TYPEC = 'student']
    GENDER = [MALE = 'male', FEMALE = 'female']
  end
end