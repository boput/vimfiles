vim9script
language messages C.UTF-8

# if has('langmap') && exists('+langremap')
   # Prevent that the langmap option applies to characters that result from a mapping.
   # https://github.com/vim/vim/issues/3018
#   set langremap
#  endif

# # Keymap внутренняя раскладка + langmap (который надо использовать по минимуму)
# if has('osx')
#      set keymap=croatian_utf-8
#      set langmap=qwertzuiopšđž;qwertyuiop[]\\;
#      set langmap+=asdfghjklčć;asdfghjkl;'
#      set langmap+=yxcvbnm;zxcvbnm
#      set langmap+=QWERTZUIOPŠĐŽ;QWERTYUIOP{};
#      set langmap+=ASDFGHJKLČĆ;ASDFGHJKL:"
#      set langmap+=YXCVBNM;ZXCVBNM
#      set langmap+=№#
#      # set langmap+=./
# else
#      # windows builds lack all vim keymaps
#      set keymap=croatian_utf-8
#      set langmap=qwertzuiopšđž;qwertyuiop[]\\;
#      set langmap+=asdfghjklčć;asdfghjkl;'
#      set langmap+=yxcvbnm;zxcvbnm
#      set langmap+=QWERTZUIOPŠĐŽ;QWERTYUIOP{};
#      set langmap+=ASDFGHJKLČĆ;ASDFGHJKL:"
#      set langmap+=YXCVBNM;ZXCVBNM
#      set langmap+=№#
#      # breaks english .
#      # set langmap+=./
#  endif

# set iminsert=0
# set imsearch=-1
