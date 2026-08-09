set history save
set verbose off
set print pretty on
set print array off
set debuginfod enabled on

tui new-layout small src 1 {-horizontal asm 2 regs 3} 2 cmd 2 status 1
tui new-layout big -horizontal {src 2 status 1 asm 1}1 {regs 1 cmd 1}1
tui new-layout vert src 1 asm 1 status 1 cmd 1

set tui border-mode half
set tui active-border-mode bold
set tui tab-width 4
set tui compact-source on

layout vert
focus cmd

define p_link_list
	set var $n = $arg0
	while $n
		print *($n)
		set var $n = $n->next
	end
end

define p_lldata
	set var $n = $arg0
	set var $t = $arg1
	while $n
		print *($t*)$n->data
		set var $n = $n->next
	end
end
