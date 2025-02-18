NAME        = so_long

CFLAGS      = -Wall -Wextra -Werror -g
MLX42_DIR   = ./MLX42
MLX42_INC   = $(MLX42_DIR)/include
MLX42_LIB   = $(MLX42_DIR)

INC         = -I. -I/usr/local/include -I$(MLX42_INC) -Iincludes

OBJ_DIR     = obj/
SRC_DIR     = src/

SRC_FILES   = main check_map check_objects check_way collects draw_map images init_game key_hook map move utils

SRCS        = $(addprefix $(SRC_DIR), $(addsuffix .c, $(SRC_FILES)))
OBJS        = $(addprefix $(OBJ_DIR), $(addsuffix .o, $(SRC_FILES)))
OBJF        = .cache_exists

LIBFT       = libft/libft.a

NO_COLOR    = \033[0m
BOLD        = \033[1m
RED         = \033[31;1m
GREEN       = \033[32;1m
YELLOW      = \033[33;1m
BLUE        = \033[34;1m

LIBS        = -L/usr/local/lib -L$(MLX42_LIB) -lmlx42 -lglfw -ldl -lm

all: $(NAME)

$(NAME): $(OBJS) $(LIBFT)
	@echo "$(YELLOW)Compiling $(NAME)...$(NO_COLOR)"
	@gcc $(CFLAGS) $(INC) $(OBJS) $(LIBFT) $(LIBS) -o $(NAME) -lreadline > /dev/null
	@echo "$(GREEN)Compilation of $(NAME) done!$(NO_COLOR)"

$(LIBFT):
	@echo "$(YELLOW)Compiling libft...$(NO_COLOR)"
	@make -s all -C libft > /dev/null
	@echo "$(GREEN)Compilation of libft done!$(NO_COLOR)"

$(OBJ_DIR)%.o: $(SRC_DIR)%.c | $(OBJF)
	@echo "$(YELLOW)Compiling $<...$(NO_COLOR)"
	@gcc $(CFLAGS) $(INC) -c $< -o $@ > /dev/null

$(OBJF):
	@mkdir -p $(OBJ_DIR)

clean:
	@echo "$(YELLOW)Cleaning objects...$(NO_COLOR)"
	@rm -f $(OBJS)
	@make clean -C libft > /dev/null
	@echo "$(GREEN)Objects cleaned.$(NO_COLOR)"

fclean: clean
	@echo "$(YELLOW)Cleaning executable...$(NO_COLOR)"
	@rm -f $(NAME)
	@make fclean -C libft > /dev/null
	@echo "$(GREEN)Executable cleaned.$(NO_COLOR)"

re: fclean all

.PHONY: all clean fclean re
