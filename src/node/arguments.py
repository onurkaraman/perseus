from base import Base

# **To-do** Handle variable or keyword arguments.
class arguments(Base):
    def compile(self):
        return ', '.join(self.args)