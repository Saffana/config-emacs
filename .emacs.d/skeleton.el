;; Source : http://www.developpez.net/forums/d880667/c-cpp/outils-c-cpp/autres/config-emacs/

;; Cree l'entete d'un fichier C                                         
(add-hook 'find-file-hook
          (lambda()
            (if (and
                 (string-match "\\.c$" (buffer-file-name))
                 (= (buffer-size) 0))
                (insert-header
                 (goto-line 13)))))

;; Skeleton des fichiers C
(define-skeleton insert-header
  "Normalize your c files."
  ""
  ;;'(setq author ("YOUR NAME HERE"))
  "/*******************************************************************************\n"
  "*\n"
  "* File Name         : "(file-name-nondirectory (buffer-file-name))"\n"
  "* Created By        : YOUR NAME HERE\n"
  "* Creation Date     : \n"
  "* Last Change       : \n"
  "* Last Changed By   : \n"
  "* Purpose           : \n"
  "* \n"
  "*******************************************************************************/ \n"
  "\n")


;; Si header vide, creer un header protege                                         
(add-hook 'find-file-hook
          (lambda()
            (if (and
                 (string-match "\\.h$" (buffer-file-name))
                 (= (buffer-size) 0))
                (insert-protect-header
                 (goto-line 14)))))

;; Skeleton des headers protege
(define-skeleton insert-protect-header
  "Inserts a define to protect the header file."
  ""
  '(setq str (file-name-sans-extension
	      (file-name-nondirectory (buffer-file-name))))
  "/* *********************************************/ \n"
  "/* Author : YOUR NAME HERE                     \n" 
  "/* File : "(file-name-nondirectory (buffer-file-name))"\n"
  "/* *********************************************/ \n"
  "\n"
  "#ifndef __"(upcase str)"_H__\n"
  "#define __"(upcase str)"_H__\n"
  "\n"
  "\n"
  "\n"
  "#endif /* !__"(upcase str)"_H__ */\n")

;; Si Makefile vide, creer un makefile
(add-hook 'find-file-hook
          (lambda()
            (if (and
                 (string-match "\\Makefile$" (buffer-file-name))
                 (= (buffer-size) 0))
                (create-makefile))))

;; Skeleton des Makefiles
(define-skeleton create-makefile
  "Create a Makefile."
  ""
  "# *********************************************\n"
  "# Author : YOUR NAME HERE\n" 
  "# File : "(file-name-nondirectory (buffer-file-name))"\n"
  "# *********************************************\n"
  "\n"
  "NAME = \n"
  "\n"
  "SRCDIR = .\n"
  "OBJDIR = .\n"
  "\n"
  "SRC = \n"
  "\n"
  "LIB = \n"
  "INC = -I -Iinclude/\n"
  "\n"
  "OBJ = $(SRC:.c=.o)\n"
  "CC = /usr/bin/gcc\n"
  "CFLAGS = -O2\n"
  "CDEBUG= -W -Wall -ansi -pedantic -g -ggdb\n"
  "RM  = rm -f\n"
  "ECHO  = echo -e\n"
  "\n"
  "$(NAME) : $(OBJ)\n"
  "\t@$(CC) $(INC) $(CFLAGS) -o $(NAME) $(OBJDIR)/$(OBJ) $(LIB)\n"
  "\t@$(ECHO) '\\033[0;32m> Compiled\\033[0m'\n"
  "\n"
  "clean :\n"
  "\t-@$(RM) $(OBJ)\n"
  "\t-@$(RM) *~\n"
  "\t-@$(RM) \#*\#\n"
  "\t@$(ECHO) '\\033[0;35m> Directory cleaned\\033[0m'\n"
  "\n"
  "all : $(NAME)\n"
  "\n"
  "fclean : clean\n"
  "\t-@$(RM) $(NAME)\n"
  "\t@$(ECHO) '\\033[0;35m> Remove executable\\033[0m'\n"
  "\n"
  "re : fclean all\n"
  "\n"
  ".PHONY : all clean re\n"
  "\n"
  "debug : $(OBJ)\n"
  "\t@$(CC) $(INC) $(CDEBUG) -o $(NAME) $(OBJDIR)/$(OBJ) $(LIB)\n"
  "\t@$(ECHO) '\\033[0;32m> Mode Debug: done\\033[0m'\n"
  "\n"
  ".c.o : \n"
  "\t$(CC) $(INC) $(CFLAGS) -o $(OBJDIR)/$@ -c $<\n")
