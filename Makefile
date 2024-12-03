COMP=g++
FLaGS=-Wall -Wextra -O3 # -g
TARGET=main
SRCS=src/main.cpp
INCLUDE_PATHS=
LIB_PATHS=
LIBS=

OBJS=$(patsubst %.cpp,%.o,$(SRCS))
INCLUDE_FLAGS=$(patsubst %,-I%,$(INCLUDE_PATHS))`pkg-config --cflags gtkmm-3.0`
LIB_PATH_FLAGS=$(patsubst %,-L%,$(LIB_PATHS))
LIB_FLAGS=$(patsubst %,-l%,$(LIBS))
DEPS=$(patsubst %.cpp,%.d,$(SRCS))

all: $(TARGET)

clean:
	rm -f $(DEPS) $(OBJS) $(TARGET)

remake:
	make clean
	make

$(TARGET): $(DEPS) $(OBJS)
	$(COMP) $(FLAGS) $(OBJS) -o $@ $(LIB_PATH_FLAGS) $(LIB_FLAGS)

-include $(DEPS)

%.o %.d: %.cpp
	$(COMP) $(FLAGS) -c $< -o $*.o -MMD -MP -MF $*.d $(INCLUDE_FLAGS)
