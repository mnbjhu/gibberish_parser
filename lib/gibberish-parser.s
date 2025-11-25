.data
.balign 8
match_just:
	.ascii "Matched just %d\n"
	.byte 0
/* end data */

.data
.balign 8
eof_just:
	.ascii "Eof just %d\n"
	.byte 0
/* end data */

.data
.balign 8
skipped_just:
	.ascii "Skipped just %d\n"
	.byte 0
/* end data */

.data
.balign 8
break_just:
	.ascii "Break just %d\n"
	.byte 0
/* end data */

.data
.balign 8
err_just:
	.ascii "Err just %d\n"
	.byte 0
/* end data */

.text
.globl test_vec_contains
test_vec_contains:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $8, %esi
	leaq -24(%rbp), %rdi
	callq new_vec
	movq %rax, %rbx
	movl $0, %esi
	movq %rbx, %rdi
	callq push_long
	movl $1, %esi
	movq %rbx, %rdi
	callq push_long
	movl $2, %esi
	movq %rbx, %rdi
	callq push_long
	movq %r12, %rax
	movq 0(%rbx), %rcx
	movq %rcx, 0(%rax)
	movq 8(%rbx), %rcx
	movq %rcx, 8(%rax)
	movq 16(%rbx), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type test_vec_contains, @function
.size test_vec_contains, .-test_vec_contains
/* end function test_vec_contains */

.text
is_eof:
	pushq %rbp
	movq %rsp, %rbp
	movq 8(%rdi), %rax
	movq 48(%rdi), %rcx
	cmpq %rax, %rcx
	setz %al
	movzbl %al, %eax
	leave
	ret
.type is_eof, @function
.size is_eof, .-is_eof
/* end function is_eof */

.data
.balign 8
skipping_token:
	.ascii "Skipping token %u\n"
	.byte 0
/* end data */

.text
.globl skip
skip:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	addq $80, %rdi
	movq %rsi, %r12
	movq %rdi, %rbx
	callq contains_long
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb6
	callq push_long
	movl $1, %eax
	jmp .Lbb7
.Lbb6:
	movl $0, %eax
.Lbb7:
	popq %r12
	popq %rbx
	leave
	ret
.type skip, @function
.size skip, .-skip
/* end function skip */

.text
.globl unskip
unskip:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	addq $80, %rdi
	movq %rdi, %rbx
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb10
	movq %rax, %rsi
	subq $1, %rsi
	callq remove_long
	movl $1, %eax
	jmp .Lbb11
.Lbb10:
	movl $0, %eax
.Lbb11:
	popq %rbx
	leave
	ret
.type unskip, @function
.size unskip, .-unskip
/* end function unskip */

.text
remove_long:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq 8(%rdi), %rbx
	imulq $8, %rbx, %rax
	movq %rdi, %r12
	imulq $8, %rsi, %rdi
	addq $8, %rsi
	movq %rax, %rdx
	subq %rsi, %rdx
	callq memcpy
	movq %r12, %rdi
	movq %rbx, %rax
	subq $1, %rax
	movq %rax, 8(%rdi)
	movl $1, %eax
	popq %r12
	popq %rbx
	leave
	ret
.type remove_long, @function
.size remove_long, .-remove_long
/* end function remove_long */

.data
.balign 8
checking_skipped:
	.ascii "Checking %u == %u\n"
	.byte 0
/* end data */

.data
.balign 8
found_skipped:
	.ascii "Found %d\n"
	.byte 0
/* end data */

.data
.balign 8
info_msg:
	.ascii "Checking contains long for arr %u, len: %u\n"
/* end data */

.text
contains_long:
	pushq %rbp
	movq %rsp, %rbp
	movq (%rdi), %rcx
	movq 8(%rdi), %rdx
	cmpl $0, %edx
	jz .Lbb19
	movl $0, %eax
.Lbb16:
	movq (%rcx), %rdi
	cmpq %rsi, %rdi
	jz .Lbb18
	addq $1, %rax
	addq $8, %rcx
	cmpq %rdx, %rax
	jnz .Lbb16
	jmp .Lbb19
.Lbb18:
	addq $1, %rax
	jmp .Lbb20
.Lbb19:
	movl $0, %eax
.Lbb20:
	leave
	ret
.type contains_long, @function
.size contains_long, .-contains_long
/* end function contains_long */

.text
push_delim:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq %rdi, %rbx
	addq $56, %rdi
	callq push_long
	movq %rbx, %rdi
	movq 64(%rdi), %rax
	addq $2, %rax
	popq %rbx
	leave
	ret
.type push_delim, @function
.size push_delim, .-push_delim
/* end function push_delim */

.text
pop_delim:
	pushq %rbp
	movq %rsp, %rbp
	addq $56, %rdi
	movl $8, %esi
	callq pop
	movl $1, %eax
	leave
	ret
.type pop_delim, @function
.size pop_delim, .-pop_delim
/* end function pop_delim */

.text
.globl bumpN
bumpN:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
.Lbb26:
	cmpl $0, %esi
	jz .Lbb28
	movq %rsi, %r12
	subq $1, %r12
	movq %rdi, %rbx
	callq bump
	movq %r12, %rsi
	movq %rbx, %rdi
	jmp .Lbb26
.Lbb28:
	movl $1, %eax
	popq %r12
	popq %rbx
	leave
	ret
.type bumpN, @function
.size bumpN, .-bumpN
/* end function bumpN */

.text
.globl enter_group
enter_group:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	addq $24, %rdi
	movq %rdi, %rbx
	leaq -32(%rbp), %rdi
	callq new_group_node
	movq %rbx, %rdi
	movq %rax, %rdx
	movl $32, %esi
	callq push
	movl $1, %eax
	popq %rbx
	leave
	ret
.type enter_group, @function
.size enter_group, .-enter_group
/* end function enter_group */

.text
current_kind:
	pushq %rbp
	movq %rsp, %rbp
	movq 48(%rdi), %rdx
	movl $24, %esi
	callq get
	movq (%rax), %rax
	leave
	ret
.type current_kind, @function
.size current_kind, .-current_kind
/* end function current_kind */

.text
.globl kind_at_offset
kind_at_offset:
	pushq %rbp
	movq %rsp, %rbp
	movq 48(%rdi), %rax
	movq %rax, %rdx
	addq %rsi, %rdx
	movl $24, %esi
	callq get
	movq (%rax), %rax
	leave
	ret
.type kind_at_offset, @function
.size kind_at_offset, .-kind_at_offset
/* end function kind_at_offset */

.data
.balign 8
skipped_msg:
	.ascii "SKIPPED\n"
	.byte 0
/* end data */

.text
after_skipped:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq 48(%rdi), %r12
	movq 8(%rdi), %r13
	movq %rdi, %r14
	addq $80, %r14
	movl $0, %ebx
.Lbb38:
	movq %rbx, %rax
	addq %r12, %rax
	cmpq %rax, %r13
	jz .Lbb41
	movq %rbx, %rsi
	movq %rdi, %r15
	callq kind_at_offset
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	movq %r14, %rdi
	callq contains_long
	movq %r15, %rdi
	cmpl $0, %eax
	jz .Lbb41
	addq $1, %rbx
	jmp .Lbb38
.Lbb41:
	movq %rbx, %rax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type after_skipped, @function
.size after_skipped, .-after_skipped
/* end function after_skipped */

.text
.globl exit_group
exit_group:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq pop
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	callq last
	movq %rbx, %rdx
	movq %rax, %rdi
	addq $8, %rdi
	movl $32, %esi
	callq push
	movl $1, %eax
	popq %rbx
	leave
	ret
.type exit_group, @function
.size exit_group, .-exit_group
/* end function exit_group */

.text
.globl bump
bump:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq 48(%rdi), %rbx
	movq %rbx, %rdx
	movl $24, %esi
	movq %rdi, %r12
	callq get
	movq %r12, %rdi
	movq %rbx, %rcx
	addq $1, %rcx
	movq %rcx, 48(%rdi)
	movq (%rax), %rsi
	movq 8(%rax), %rdx
	movq 16(%rax), %rcx
	movq %rdi, %rbx
	leaq -32(%rbp), %rdi
	callq new_token_node
	movq %rbx, %rdi
	movq %rax, %rbx
	addq $24, %rdi
	movl $32, %esi
	callq last
	movq %rbx, %rdx
	movq %rax, %rdi
	addq $8, %rdi
	movl $32, %esi
	callq push
	movl $1, %eax
	popq %r12
	popq %rbx
	leave
	ret
.type bump, @function
.size bump, .-bump
/* end function bump */

.text
.globl missing
missing:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	movq (%rsi), %rax
	cmpl $0, %eax
	jnz .Lbb49
	movl $1, %eax
	jmp .Lbb50
.Lbb49:
	addq $24, %rdi
	movq %rsi, %rbx
	movl $32, %esi
	callq last
	movq %rbx, %rsi
	movq %rax, %rdi
	addq $8, %rdi
	movq %rdi, %rbx
	leaq -32(%rbp), %rdi
	callq new_missing_node
	movq %rbx, %rdi
	movq %rax, %rdx
	movl $32, %esi
	callq push
	movl $1, %eax
.Lbb50:
	popq %rbx
	leave
	ret
.type missing, @function
.size missing, .-missing
/* end function missing */

.text
.globl bump_err
bump_err:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq 48(%rdi), %rbx
	movq %rbx, %rdx
	movl $24, %esi
	movq %rdi, %r12
	callq get
	movq %r12, %rdi
	movq %rax, %r12
	movq %rbx, %rax
	addq $1, %rax
	movq %rax, 48(%rdi)
	addq $24, %rdi
	movl $32, %esi
	callq last
	movq %rax, %rdi
	addq $8, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq (%rax), %rcx
	cmpq $2, %rcx
	jz .Lbb53
	movq %rdi, %rbx
	leaq -32(%rbp), %rdi
	callq new_error_node
	movq %r12, %rdx
	movq %rbx, %rdi
	movq %rax, %r12
	movq %rdi, %rbx
	movq %r12, %rdi
	addq $8, %rdi
	movl $24, %esi
	callq push
	movq %r12, %rdx
	movq %rbx, %rdi
	movl $32, %esi
	callq push
	movl $1, %eax
	jmp .Lbb55
.Lbb53:
	movq %r12, %rdx
	movq %rax, %rdi
	addq $8, %rdi
	movl $24, %esi
	callq push
	movl $1, %eax
.Lbb55:
	popq %r12
	popq %rbx
	leave
	ret
.type bump_err, @function
.size bump_err, .-bump_err
/* end function bump_err */

.text
.globl default_state_ptr
default_state_ptr:
	pushq %rbp
	movq %rsp, %rbp
	subq $120, %rsp
	pushq %rbx
	movq %rsi, %rdx
	movq %rdi, %rsi
	leaq -104(%rbp), %rdi
	callq default_state
	movq %rax, %rbx
	movl $104, %edi
	callq malloc
	movq %rbx, %rsi
	movq %rax, %rbx
	movl $104, %edx
	movq %rbx, %rdi
	callq memcpy
	movq %rbx, %rax
	popq %rbx
	leave
	ret
.type default_state_ptr, @function
.size default_state_ptr, .-default_state_ptr
/* end function default_state_ptr */

.text
.globl get_state
get_state:
	pushq %rbp
	movq %rsp, %rbp
	subq $112, %rsp
	movq %rdi, %rax
	movq 0(%rsi), %rcx
	movq %rcx, -104(%rbp)
	movq 8(%rsi), %rcx
	movq %rcx, -96(%rbp)
	movq 16(%rsi), %rcx
	movq %rcx, -88(%rbp)
	movq 24(%rsi), %rcx
	movq %rcx, -80(%rbp)
	movq 32(%rsi), %rcx
	movq %rcx, -72(%rbp)
	movq 40(%rsi), %rcx
	movq %rcx, -64(%rbp)
	movq 48(%rsi), %rcx
	movq %rcx, -56(%rbp)
	movq 56(%rsi), %rcx
	movq %rcx, -48(%rbp)
	movq 64(%rsi), %rcx
	movq %rcx, -40(%rbp)
	movq 72(%rsi), %rcx
	movq %rcx, -32(%rbp)
	movq 80(%rsi), %rcx
	movq %rcx, -24(%rbp)
	movq 88(%rsi), %rcx
	movq %rcx, -16(%rbp)
	movq 96(%rsi), %rcx
	movq %rcx, -8(%rbp)
	movq -104(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -96(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -88(%rbp), %rcx
	movq %rcx, 16(%rax)
	movq -80(%rbp), %rcx
	movq %rcx, 24(%rax)
	movq -72(%rbp), %rcx
	movq %rcx, 32(%rax)
	movq -64(%rbp), %rcx
	movq %rcx, 40(%rax)
	movq -56(%rbp), %rcx
	movq %rcx, 48(%rax)
	movq -48(%rbp), %rcx
	movq %rcx, 56(%rax)
	movq -40(%rbp), %rcx
	movq %rcx, 64(%rax)
	movq -32(%rbp), %rcx
	movq %rcx, 72(%rax)
	movq -24(%rbp), %rcx
	movq %rcx, 80(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 88(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 96(%rax)
	leave
	ret
.type get_state, @function
.size get_state, .-get_state
/* end function get_state */

.text
.globl last
last:
	pushq %rbp
	movq %rsp, %rbp
	movq (%rdi), %rax
	movq 8(%rdi), %rcx
	subq $1, %rcx
	imulq %rsi, %rcx
	addq %rcx, %rax
	leave
	ret
.type last, @function
.size last, .-last
/* end function last */

.text
.globl default_state
default_state:
	pushq %rbp
	movq %rsp, %rbp
	subq $136, %rsp
	pushq %rbx
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq lex
	subq $32, %rsp
	movq %rsp, %rcx
	movq 0(%rax), %rdx
	movq %rdx, 0(%rcx)
	movq 8(%rax), %rdx
	movq %rdx, 8(%rcx)
	movq 16(%rax), %rax
	movq %rax, 16(%rcx)
	leaq -128(%rbp), %rdi
	callq new_state
	movq %rax, %rcx
	movq %rbx, %rax
	subq $-32, %rsp
	movq 0(%rcx), %rdx
	movq %rdx, 0(%rax)
	movq 8(%rcx), %rdx
	movq %rdx, 8(%rax)
	movq 16(%rcx), %rdx
	movq %rdx, 16(%rax)
	movq 24(%rcx), %rdx
	movq %rdx, 24(%rax)
	movq 32(%rcx), %rdx
	movq %rdx, 32(%rax)
	movq 40(%rcx), %rdx
	movq %rdx, 40(%rax)
	movq 48(%rcx), %rdx
	movq %rdx, 48(%rax)
	movq 56(%rcx), %rdx
	movq %rdx, 56(%rax)
	movq 64(%rcx), %rdx
	movq %rdx, 64(%rax)
	movq 72(%rcx), %rdx
	movq %rdx, 72(%rax)
	movq 80(%rcx), %rdx
	movq %rdx, 80(%rax)
	movq 88(%rcx), %rdx
	movq %rdx, 88(%rax)
	movq 96(%rcx), %rcx
	movq %rcx, 96(%rax)
	popq %rbx
	leave
	ret
.type default_state, @function
.size default_state, .-default_state
/* end function default_state */

.text
new_state:
	pushq %rbp
	movq %rsp, %rbp
	subq $216, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq %rdi, %r13
	movl root_group_id(%rip), %esi
	leaq -136(%rbp), %rdi
	callq new_group_node
	movq %rax, %rbx
	movl $32, %esi
	leaq -160(%rbp), %rdi
	callq new_vec
	movq %rbx, %rdx
	movq %rax, %r12
	movl $32, %esi
	movq %r12, %rdi
	callq push
	movl $8, %esi
	leaq -184(%rbp), %rdi
	callq new_vec
	movq %rax, %rbx
	movl $8, %esi
	leaq -208(%rbp), %rdi
	callq new_vec
	movq %rax, %rcx
	movq %r13, %rax
	movq 16(%rbp), %rdx
	movq %rdx, -104(%rbp)
	movq 24(%rbp), %rdx
	movq %rdx, -96(%rbp)
	movq 32(%rbp), %rdx
	movq %rdx, -88(%rbp)
	movq 0(%r12), %rdx
	movq %rdx, -80(%rbp)
	movq 8(%r12), %rdx
	movq %rdx, -72(%rbp)
	movq 16(%r12), %rdx
	movq %rdx, -64(%rbp)
	movq 0(%rbx), %rdx
	movq %rdx, -48(%rbp)
	movq 8(%rbx), %rdx
	movq %rdx, -40(%rbp)
	movq 16(%rbx), %rdx
	movq %rdx, -32(%rbp)
	movq 0(%rcx), %rdx
	movq %rdx, -24(%rbp)
	movq 8(%rcx), %rdx
	movq %rdx, -16(%rbp)
	movq 16(%rcx), %rcx
	movq %rcx, -8(%rbp)
	movq $0, -56(%rbp)
	movq -104(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -96(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -88(%rbp), %rcx
	movq %rcx, 16(%rax)
	movq -80(%rbp), %rcx
	movq %rcx, 24(%rax)
	movq -72(%rbp), %rcx
	movq %rcx, 32(%rax)
	movq -64(%rbp), %rcx
	movq %rcx, 40(%rax)
	movq -56(%rbp), %rcx
	movq %rcx, 48(%rax)
	movq -48(%rbp), %rcx
	movq %rcx, 56(%rax)
	movq -40(%rbp), %rcx
	movq %rcx, 64(%rax)
	movq -32(%rbp), %rcx
	movq %rcx, 72(%rax)
	movq -24(%rbp), %rcx
	movq %rcx, 80(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 88(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 96(%rax)
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type new_state, @function
.size new_state, .-new_state
/* end function new_state */

.data
.balign 8
debug_group:
	.ascii "Group { kind: %d, group_kind: %d, ptr: %d, len: %d, cap: %d, }"
	.byte 0
/* end data */

.text
print_group:
	pushq %rbp
	movq %rsp, %rbp
	movl $1, %eax
	leave
	ret
.type print_group, @function
.size print_group, .-print_group
/* end function print_group */

.text
.globl get
get:
	pushq %rbp
	movq %rsp, %rbp
	movq (%rdi), %rax
	movq %rsi, %rcx
	imulq %rdx, %rcx
	addq %rcx, %rax
	leave
	ret
.type get, @function
.size get, .-get
/* end function get */

.data
.balign 8
AHH:
	.ascii "AHHH"
	.byte 0
/* end data */

.text
.globl new_token_node
new_token_node:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, %rax
	movq $0, -32(%rbp)
	movq %rsi, -24(%rbp)
	movq %rdx, -16(%rbp)
	movq %rcx, -8(%rbp)
	movq -32(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -24(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 16(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 24(%rax)
	leave
	ret
.type new_token_node, @function
.size new_token_node, .-new_token_node
/* end function new_token_node */

.text
.globl new_missing_node
new_missing_node:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, %rax
	movq 0(%rsi), %rcx
	movq %rcx, -24(%rbp)
	movq 8(%rsi), %rcx
	movq %rcx, -16(%rbp)
	movq 16(%rsi), %rcx
	movq %rcx, -8(%rbp)
	movl $3, -32(%rbp)
	movq -32(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -24(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 16(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 24(%rax)
	leave
	ret
.type new_missing_node, @function
.size new_missing_node, .-new_missing_node
/* end function new_missing_node */

.text
.globl new_group_node
new_group_node:
	pushq %rbp
	movq %rsp, %rbp
	subq $64, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %rbx
	movl %esi, %r12d
	movl $32, %esi
	leaq -56(%rbp), %rdi
	callq new_vec
	movl %r12d, %esi
	movq %rax, %rcx
	movq %rbx, %rax
	movq 0(%rcx), %rdx
	movq %rdx, -24(%rbp)
	movq 8(%rcx), %rdx
	movq %rdx, -16(%rbp)
	movq 16(%rcx), %rcx
	movq %rcx, -8(%rbp)
	movl $1, -32(%rbp)
	movl %esi, -28(%rbp)
	movq -32(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -24(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 16(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 24(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type new_group_node, @function
.size new_group_node, .-new_group_node
/* end function new_group_node */

.text
.globl new_error_node
new_error_node:
	pushq %rbp
	movq %rsp, %rbp
	subq $72, %rsp
	pushq %rbx
	movq %rdi, %rbx
	movl $24, %esi
	leaq -56(%rbp), %rdi
	callq new_vec
	movq %rax, %rcx
	movq %rbx, %rax
	movq 0(%rcx), %rdx
	movq %rdx, -24(%rbp)
	movq 8(%rcx), %rdx
	movq %rdx, -16(%rbp)
	movq 16(%rcx), %rcx
	movq %rcx, -8(%rbp)
	movq $2, -32(%rbp)
	movq -32(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -24(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 16(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 24(%rax)
	popq %rbx
	leave
	ret
.type new_error_node, @function
.size new_error_node, .-new_error_node
/* end function new_error_node */

.text
.globl new_vec
new_vec:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	movq %rdi, %rbx
	imulq $4, %rsi, %rdi
	callq malloc
	movq %rax, %rcx
	movq %rbx, %rax
	movq %rcx, -24(%rbp)
	movq $0, -16(%rbp)
	movq $4, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %rbx
	leave
	ret
.type new_vec, @function
.size new_vec, .-new_vec
/* end function new_vec */

.text
.globl new_token
new_token:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, %rax
	movq %rsi, -24(%rbp)
	movq %rdx, -16(%rbp)
	movq %rcx, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	leave
	ret
.type new_token, @function
.size new_token, .-new_token
/* end function new_token */

.text
.globl pop
pop:
	pushq %rbp
	movq %rsp, %rbp
	movq (%rdi), %rcx
	movq 8(%rdi), %rax
	subq $1, %rax
	movq %rax, 8(%rdi)
	imulq %rsi, %rax
	addq %rcx, %rax
	leave
	ret
.type pop, @function
.size pop, .-pop
/* end function pop */

.text
.globl push_long
push_long:
	pushq %rbp
	movq %rsp, %rbp
	subq $24, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rsi, %r13
	movq %rdi, %rbx
	addq $8, %rbx
	movq %rbx, -16(%rbp)
	movq %rdi, %rax
	addq $16, %rax
	movq %rax, -8(%rbp)
	movq (%rdi), %r15
	movq 8(%rdi), %r12
	movq 16(%rdi), %rax
	cmpq %rax, %r12
	jz .Lbb86
	movq %r13, %rsi
	movq %rbx, %r13
	movq %r15, %rbx
	jmp .Lbb87
.Lbb86:
	imulq $4, %rax, %r14
	movq %rdi, %rbx
	imulq $8, %r14, %rdi
	callq malloc
	movq %r13, %rsi
	movq %rbx, %rdi
	movq %rax, %rbx
	movq -8(%rbp), %rax
	movq -16(%rbp), %r13
	movq %r14, (%rax)
	movq %rbx, (%rdi)
	imulq $8, %r12, %rdx
	movq %rsi, %r14
	movq %r15, %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r15, %rdi
	callq free
	movq %r14, %rsi
.Lbb87:
	movq %r12, %rax
	addq $1, %rax
	movq %rax, (%r13)
	movq %rsi, (%rbx, %r12, 8)
	movl $1, %eax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type push_long, @function
.size push_long, .-push_long
/* end function push_long */

.text
.globl push
push:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rsi, %r15
	movq %rdx, %rsi
	movq %rsi, -24(%rbp)
	movq %rdi, %rbx
	addq $8, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rax
	addq $16, %rax
	movq %rax, -16(%rbp)
	movq %rbx, %r13
	movq (%rdi), %rbx
	movq 8(%rdi), %r12
	movq 16(%rdi), %rax
	cmpq %rax, %r12
	jz .Lbb91
	movq %r15, %rdx
	xchgq %r13, %rbx
	jmp .Lbb92
.Lbb91:
	imulq $4, %rax, %r14
	movq %rdi, %r13
	movq %r14, %rdi
	imulq %r15, %rdi
	callq malloc
	movq %r15, %rdx
	movq %r13, %rdi
	movq %rax, %r13
	movq -16(%rbp), %rax
	movq -24(%rbp), %rsi
	movq %r14, (%rax)
	movq %r13, (%rdi)
	movq %rdx, %r15
	imulq %r12, %rdx
	movq %rsi, %r14
	movq %rbx, %rsi
	movq %r13, %rdi
	callq memcpy
	movq %rbx, %rax
	movq -32(%rbp), %rbx
	movq %rax, %rdi
	callq free
	movq %r15, %rdx
	movq %r14, %rsi
.Lbb92:
	movq %r12, %rax
	imulq %rdx, %rax
	movq %rax, %rdi
	addq %r13, %rdi
	movq %r12, %rax
	addq $1, %rax
	movq %rax, (%rbx)
	callq memcpy
	movl $1, %eax
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type push, @function
.size push, .-push
/* end function push */

.text
.globl free_node
free_node:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq %rdi, %rax
	movl (%rax), %ecx
	cmpl $0, %ecx
	jz .Lbb106
	cmpl $1, %ecx
	jz .Lbb100
	cmpl $2, %ecx
	jz .Lbb99
	cmpl $3, %ecx
	jnz .Lbb106
	movq 8(%rax), %rdi
	callq free
	jmp .Lbb106
.Lbb99:
	movq 8(%rax), %rdi
	callq free
	jmp .Lbb106
.Lbb100:
	movq 8(%rax), %rdi
	movq 16(%rax), %r13
	movq %rdi, %r12
	movl $0, %ebx
.Lbb102:
	cmpq %r13, %rbx
	jae .Lbb104
	imulq $32, %rbx, %rax
	movq %r12, %rdi
	addq %rax, %rdi
	callq free_node
	addq $1, %rbx
	jmp .Lbb102
.Lbb104:
	movq %r12, %rdi
	callq free
.Lbb106:
	movl $1, %eax
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type free_node, @function
.size free_node, .-free_node
/* end function free_node */

.text
.globl free_state
free_state:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movq %rdi, %rbx
	movq (%rdi), %rdi
	callq free
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq 24(%rdi), %rdi
	movq 32(%rbx), %r13
	movq %rdi, %r12
	movq %rbx, %rdi
	movl $0, %ebx
.Lbb110:
	cmpq %r13, %rbx
	jae .Lbb112
	imulq $32, %rbx, %rax
	movq %rdi, %r14
	movq %r12, %rdi
	addq %rax, %rdi
	callq free_node
	movq %r14, %rdi
	addq $1, %rbx
	jmp .Lbb110
.Lbb112:
	movq %rdi, %rbx
	movq %r12, %rdi
	callq free
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq 56(%rdi), %rdi
	callq free
	movq %rbx, %rdi
	movq 80(%rdi), %rdi
	callq free
	movl $1, %eax
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type free_state, @function
.size free_state, .-free_state
/* end function free_state */

.data
.balign 8
offset_ptr:
	.quad 0
/* end data */

.data
.balign 8
group_end:
	.quad 0
/* end data */

.text
cmp_current:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rdi, %rax, 1), %eax
	cmpl %edx, %eax
	setz %al
	movzbl %al, %eax
	leave
	ret
.type cmp_current, @function
.size cmp_current, .-cmp_current
/* end function cmp_current */

.text
inc_offset:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	addq $1, %rax
	movq %rax, offset_ptr(%rip)
	movl $0, %eax
	leave
	ret
.type inc_offset, @function
.size inc_offset, .-inc_offset
/* end function inc_offset */

.text
lex_1:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movq offset_ptr(%rip), %rbx
	movl $107, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb127
	movl $101, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb127
	movl $121, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb127
	movl $119, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb127
	movl $111, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb127
	movl $114, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb127
	movl $100, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb128
.Lbb127:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb129
.Lbb128:
	movl $1, %eax
.Lbb129:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_1, @function
.size lex_1, .-lex_1
/* end function lex_1 */

.text
lex_3:
	pushq %rbp
	movq %rsp, %rbp
	movl $95, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb132
	movl $0, %eax
	jmp .Lbb133
.Lbb132:
	callq inc_offset
	movl $1, %eax
.Lbb133:
	leave
	ret
.type lex_3, @function
.size lex_3, .-lex_3
/* end function lex_3 */

.text
lex_4:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $97, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $122, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb136
	movl $0, %eax
	jmp .Lbb137
.Lbb136:
	callq inc_offset
	movl $1, %eax
.Lbb137:
	leave
	ret
.type lex_4, @function
.size lex_4, .-lex_4
/* end function lex_4 */

.text
lex_5:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $65, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $90, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb140
	movl $0, %eax
	jmp .Lbb141
.Lbb140:
	callq inc_offset
	movl $1, %eax
.Lbb141:
	leave
	ret
.type lex_5, @function
.size lex_5, .-lex_5
/* end function lex_5 */

.text
lex_2:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_3
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb149
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_4
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb149
	movq %rsi, %r12
	callq lex_5
	movq %r12, %rsi
	cmpl $0, %eax
	jnz .Lbb149
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb148
	callq inc_offset
	movl $1, %eax
	jmp .Lbb150
.Lbb148:
	movl $1, %eax
	jmp .Lbb150
.Lbb149:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
.Lbb150:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_2, @function
.size lex_2, .-lex_2
/* end function lex_2 */

.text
lex_0:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_1
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb154
	callq lex_2
	cmpl $0, %eax
	jnz .Lbb155
.Lbb154:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb156
.Lbb155:
	movl $1, %eax
.Lbb156:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_0, @function
.size lex_0, .-lex_0
/* end function lex_0 */

.text
lex_KEYWORD:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_0
	cmpl $0, %eax
	jnz .Lbb159
	movl $0, %eax
	jmp .Lbb161
.Lbb159:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb161
	movq offset_ptr(%rip), %rax
.Lbb161:
	leave
	ret
.type lex_KEYWORD, @function
.size lex_KEYWORD, .-lex_KEYWORD
/* end function lex_KEYWORD */

.text
lex_7:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movq offset_ptr(%rip), %rbx
	movl $112, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb169
	movl $97, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb169
	movl $114, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb169
	movl $115, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb169
	movl $101, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb169
	movl $114, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb170
.Lbb169:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb171
.Lbb170:
	movl $1, %eax
.Lbb171:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_7, @function
.size lex_7, .-lex_7
/* end function lex_7 */

.text
lex_9:
	pushq %rbp
	movq %rsp, %rbp
	movl $95, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb174
	movl $0, %eax
	jmp .Lbb175
.Lbb174:
	callq inc_offset
	movl $1, %eax
.Lbb175:
	leave
	ret
.type lex_9, @function
.size lex_9, .-lex_9
/* end function lex_9 */

.text
lex_10:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $97, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $122, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb178
	movl $0, %eax
	jmp .Lbb179
.Lbb178:
	callq inc_offset
	movl $1, %eax
.Lbb179:
	leave
	ret
.type lex_10, @function
.size lex_10, .-lex_10
/* end function lex_10 */

.text
lex_11:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $65, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $90, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb182
	movl $0, %eax
	jmp .Lbb183
.Lbb182:
	callq inc_offset
	movl $1, %eax
.Lbb183:
	leave
	ret
.type lex_11, @function
.size lex_11, .-lex_11
/* end function lex_11 */

.text
lex_8:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_9
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb191
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_10
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb191
	movq %rsi, %r12
	callq lex_11
	movq %r12, %rsi
	cmpl $0, %eax
	jnz .Lbb191
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb190
	callq inc_offset
	movl $1, %eax
	jmp .Lbb192
.Lbb190:
	movl $1, %eax
	jmp .Lbb192
.Lbb191:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
.Lbb192:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_8, @function
.size lex_8, .-lex_8
/* end function lex_8 */

.text
lex_6:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_7
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb196
	callq lex_8
	cmpl $0, %eax
	jnz .Lbb197
.Lbb196:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb198
.Lbb197:
	movl $1, %eax
.Lbb198:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_6, @function
.size lex_6, .-lex_6
/* end function lex_6 */

.text
lex_PARSER:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_6
	cmpl $0, %eax
	jnz .Lbb201
	movl $0, %eax
	jmp .Lbb203
.Lbb201:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb203
	movq offset_ptr(%rip), %rax
.Lbb203:
	leave
	ret
.type lex_PARSER, @function
.size lex_PARSER, .-lex_PARSER
/* end function lex_PARSER */

.text
lex_13:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movq offset_ptr(%rip), %rbx
	movl $116, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb210
	movl $111, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb210
	movl $107, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb210
	movl $101, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb210
	movl $110, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb211
.Lbb210:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb212
.Lbb211:
	movl $1, %eax
.Lbb212:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_13, @function
.size lex_13, .-lex_13
/* end function lex_13 */

.text
lex_15:
	pushq %rbp
	movq %rsp, %rbp
	movl $95, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb215
	movl $0, %eax
	jmp .Lbb216
.Lbb215:
	callq inc_offset
	movl $1, %eax
.Lbb216:
	leave
	ret
.type lex_15, @function
.size lex_15, .-lex_15
/* end function lex_15 */

.text
lex_16:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $97, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $122, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb219
	movl $0, %eax
	jmp .Lbb220
.Lbb219:
	callq inc_offset
	movl $1, %eax
.Lbb220:
	leave
	ret
.type lex_16, @function
.size lex_16, .-lex_16
/* end function lex_16 */

.text
lex_17:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $65, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $90, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb223
	movl $0, %eax
	jmp .Lbb224
.Lbb223:
	callq inc_offset
	movl $1, %eax
.Lbb224:
	leave
	ret
.type lex_17, @function
.size lex_17, .-lex_17
/* end function lex_17 */

.text
lex_14:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_15
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb232
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_16
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb232
	movq %rsi, %r12
	callq lex_17
	movq %r12, %rsi
	cmpl $0, %eax
	jnz .Lbb232
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb231
	callq inc_offset
	movl $1, %eax
	jmp .Lbb233
.Lbb231:
	movl $1, %eax
	jmp .Lbb233
.Lbb232:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
.Lbb233:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_14, @function
.size lex_14, .-lex_14
/* end function lex_14 */

.text
lex_12:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_13
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb237
	callq lex_14
	cmpl $0, %eax
	jnz .Lbb238
.Lbb237:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb239
.Lbb238:
	movl $1, %eax
.Lbb239:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_12, @function
.size lex_12, .-lex_12
/* end function lex_12 */

.text
lex_TOKEN:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_12
	cmpl $0, %eax
	jnz .Lbb242
	movl $0, %eax
	jmp .Lbb244
.Lbb242:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb244
	movq offset_ptr(%rip), %rax
.Lbb244:
	leave
	ret
.type lex_TOKEN, @function
.size lex_TOKEN, .-lex_TOKEN
/* end function lex_TOKEN */

.text
lex_19:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movq offset_ptr(%rip), %rbx
	movl $104, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $105, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $103, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $104, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $108, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $105, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $103, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $104, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb255
	movl $116, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb256
.Lbb255:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb257
.Lbb256:
	movl $1, %eax
.Lbb257:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_19, @function
.size lex_19, .-lex_19
/* end function lex_19 */

.text
lex_21:
	pushq %rbp
	movq %rsp, %rbp
	movl $95, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb260
	movl $0, %eax
	jmp .Lbb261
.Lbb260:
	callq inc_offset
	movl $1, %eax
.Lbb261:
	leave
	ret
.type lex_21, @function
.size lex_21, .-lex_21
/* end function lex_21 */

.text
lex_22:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $97, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $122, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb264
	movl $0, %eax
	jmp .Lbb265
.Lbb264:
	callq inc_offset
	movl $1, %eax
.Lbb265:
	leave
	ret
.type lex_22, @function
.size lex_22, .-lex_22
/* end function lex_22 */

.text
lex_23:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $65, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $90, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb268
	movl $0, %eax
	jmp .Lbb269
.Lbb268:
	callq inc_offset
	movl $1, %eax
.Lbb269:
	leave
	ret
.type lex_23, @function
.size lex_23, .-lex_23
/* end function lex_23 */

.text
lex_20:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_21
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb277
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_22
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb277
	movq %rsi, %r12
	callq lex_23
	movq %r12, %rsi
	cmpl $0, %eax
	jnz .Lbb277
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb276
	callq inc_offset
	movl $1, %eax
	jmp .Lbb278
.Lbb276:
	movl $1, %eax
	jmp .Lbb278
.Lbb277:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
.Lbb278:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_20, @function
.size lex_20, .-lex_20
/* end function lex_20 */

.text
lex_18:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_19
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb282
	callq lex_20
	cmpl $0, %eax
	jnz .Lbb283
.Lbb282:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb284
.Lbb283:
	movl $1, %eax
.Lbb284:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_18, @function
.size lex_18, .-lex_18
/* end function lex_18 */

.text
lex_HIGHTLIGHT:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_18
	cmpl $0, %eax
	jnz .Lbb287
	movl $0, %eax
	jmp .Lbb289
.Lbb287:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb289
	movq offset_ptr(%rip), %rax
.Lbb289:
	leave
	ret
.type lex_HIGHTLIGHT, @function
.size lex_HIGHTLIGHT, .-lex_HIGHTLIGHT
/* end function lex_HIGHTLIGHT */

.text
lex_25:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movq offset_ptr(%rip), %rbx
	movl $102, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb295
	movl $111, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb295
	movl $108, %edx
	movq %rsi, %r14
	movq %rdi, %r13
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	movq %r14, %rsi
	movq %r13, %rdi
	cmpl $0, %r12d
	jz .Lbb295
	movl $100, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb296
.Lbb295:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb297
.Lbb296:
	movl $1, %eax
.Lbb297:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_25, @function
.size lex_25, .-lex_25
/* end function lex_25 */

.text
lex_27:
	pushq %rbp
	movq %rsp, %rbp
	movl $95, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb300
	movl $0, %eax
	jmp .Lbb301
.Lbb300:
	callq inc_offset
	movl $1, %eax
.Lbb301:
	leave
	ret
.type lex_27, @function
.size lex_27, .-lex_27
/* end function lex_27 */

.text
lex_28:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $97, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $122, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb304
	movl $0, %eax
	jmp .Lbb305
.Lbb304:
	callq inc_offset
	movl $1, %eax
.Lbb305:
	leave
	ret
.type lex_28, @function
.size lex_28, .-lex_28
/* end function lex_28 */

.text
lex_29:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $65, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $90, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb308
	movl $0, %eax
	jmp .Lbb309
.Lbb308:
	callq inc_offset
	movl $1, %eax
.Lbb309:
	leave
	ret
.type lex_29, @function
.size lex_29, .-lex_29
/* end function lex_29 */

.text
lex_26:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_27
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb317
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_28
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb317
	movq %rsi, %r12
	callq lex_29
	movq %r12, %rsi
	cmpl $0, %eax
	jnz .Lbb317
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb316
	callq inc_offset
	movl $1, %eax
	jmp .Lbb318
.Lbb316:
	movl $1, %eax
	jmp .Lbb318
.Lbb317:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
.Lbb318:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_26, @function
.size lex_26, .-lex_26
/* end function lex_26 */

.text
lex_24:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_25
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb322
	callq lex_26
	cmpl $0, %eax
	jnz .Lbb323
.Lbb322:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb324
.Lbb323:
	movl $1, %eax
.Lbb324:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_24, @function
.size lex_24, .-lex_24
/* end function lex_24 */

.text
lex_FOLD:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_24
	cmpl $0, %eax
	jnz .Lbb327
	movl $0, %eax
	jmp .Lbb329
.Lbb327:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb329
	movq offset_ptr(%rip), %rax
.Lbb329:
	leave
	ret
.type lex_FOLD, @function
.size lex_FOLD, .-lex_FOLD
/* end function lex_FOLD */

.text
lex_32:
	pushq %rbp
	movq %rsp, %rbp
	movl $32, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb332
	movl $0, %eax
	jmp .Lbb333
.Lbb332:
	callq inc_offset
	movl $1, %eax
.Lbb333:
	leave
	ret
.type lex_32, @function
.size lex_32, .-lex_32
/* end function lex_32 */

.text
lex_33:
	pushq %rbp
	movq %rsp, %rbp
	movl $9, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb336
	movl $0, %eax
	jmp .Lbb337
.Lbb336:
	callq inc_offset
	movl $1, %eax
.Lbb337:
	leave
	ret
.type lex_33, @function
.size lex_33, .-lex_33
/* end function lex_33 */

.text
lex_34:
	pushq %rbp
	movq %rsp, %rbp
	movl $10, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb340
	movl $0, %eax
	jmp .Lbb341
.Lbb340:
	callq inc_offset
	movl $1, %eax
.Lbb341:
	leave
	ret
.type lex_34, @function
.size lex_34, .-lex_34
/* end function lex_34 */

.text
lex_31:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_32
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb347
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_33
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb347
	movq %rbx, offset_ptr(%rip)
	callq lex_34
	cmpl $0, %eax
	jnz .Lbb347
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb348
.Lbb347:
	movl $1, %eax
.Lbb348:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_31, @function
.size lex_31, .-lex_31
/* end function lex_31 */

.text
lex_35:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb354
	movq %rsi, %r12
	movq %rdi, %rbx
	callq lex_31
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb354
.Lbb351:
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb353
	movq %rsi, %r12
	movq %rdi, %rbx
	callq lex_31
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb351
.Lbb353:
	movl $1, %eax
	jmp .Lbb355
.Lbb354:
	movl $0, %eax
.Lbb355:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_35, @function
.size lex_35, .-lex_35
/* end function lex_35 */

.text
lex_30:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_35
	cmpl $0, %eax
	jnz .Lbb359
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb360
.Lbb359:
	movl $1, %eax
.Lbb360:
	popq %rbx
	leave
	ret
.type lex_30, @function
.size lex_30, .-lex_30
/* end function lex_30 */

.text
lex_whitespace:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_30
	cmpl $0, %eax
	jnz .Lbb363
	movl $0, %eax
	jmp .Lbb365
.Lbb363:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb365
	movq offset_ptr(%rip), %rax
.Lbb365:
	leave
	ret
.type lex_whitespace, @function
.size lex_whitespace, .-lex_whitespace
/* end function lex_whitespace */

.text
lex_38:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $48, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $57, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb368
	movl $0, %eax
	jmp .Lbb369
.Lbb368:
	callq inc_offset
	movl $1, %eax
.Lbb369:
	leave
	ret
.type lex_38, @function
.size lex_38, .-lex_38
/* end function lex_38 */

.text
lex_37:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	movq %rbx, offset_ptr(%rip)
	callq lex_38
	cmpl $0, %eax
	jnz .Lbb373
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb374
.Lbb373:
	movl $1, %eax
.Lbb374:
	popq %rbx
	leave
	ret
.type lex_37, @function
.size lex_37, .-lex_37
/* end function lex_37 */

.text
lex_39:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb380
	movq %rsi, %r12
	movq %rdi, %rbx
	callq lex_37
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb380
.Lbb377:
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb379
	movq %rsi, %r12
	movq %rdi, %rbx
	callq lex_37
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb377
.Lbb379:
	movl $1, %eax
	jmp .Lbb381
.Lbb380:
	movl $0, %eax
.Lbb381:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_39, @function
.size lex_39, .-lex_39
/* end function lex_39 */

.text
lex_36:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_39
	cmpl $0, %eax
	jnz .Lbb385
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb386
.Lbb385:
	movl $1, %eax
.Lbb386:
	popq %rbx
	leave
	ret
.type lex_36, @function
.size lex_36, .-lex_36
/* end function lex_36 */

.text
lex_int:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_36
	cmpl $0, %eax
	jnz .Lbb389
	movl $0, %eax
	jmp .Lbb391
.Lbb389:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb391
	movq offset_ptr(%rip), %rax
.Lbb391:
	leave
	ret
.type lex_int, @function
.size lex_int, .-lex_int
/* end function lex_int */

.text
lex_41:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $58, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb395
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb396
.Lbb395:
	movl $1, %eax
.Lbb396:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_41, @function
.size lex_41, .-lex_41
/* end function lex_41 */

.text
lex_40:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_41
	cmpl $0, %eax
	jnz .Lbb400
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb401
.Lbb400:
	movl $1, %eax
.Lbb401:
	popq %rbx
	leave
	ret
.type lex_40, @function
.size lex_40, .-lex_40
/* end function lex_40 */

.text
lex_colon:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_40
	cmpl $0, %eax
	jnz .Lbb404
	movl $0, %eax
	jmp .Lbb406
.Lbb404:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb406
	movq offset_ptr(%rip), %rax
.Lbb406:
	leave
	ret
.type lex_colon, @function
.size lex_colon, .-lex_colon
/* end function lex_colon */

.text
lex_43:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $44, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb410
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb411
.Lbb410:
	movl $1, %eax
.Lbb411:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_43, @function
.size lex_43, .-lex_43
/* end function lex_43 */

.text
lex_42:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_43
	cmpl $0, %eax
	jnz .Lbb415
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb416
.Lbb415:
	movl $1, %eax
.Lbb416:
	popq %rbx
	leave
	ret
.type lex_42, @function
.size lex_42, .-lex_42
/* end function lex_42 */

.text
lex_comma:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_42
	cmpl $0, %eax
	jnz .Lbb419
	movl $0, %eax
	jmp .Lbb421
.Lbb419:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb421
	movq offset_ptr(%rip), %rax
.Lbb421:
	leave
	ret
.type lex_comma, @function
.size lex_comma, .-lex_comma
/* end function lex_comma */

.text
lex_45:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $124, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb425
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb426
.Lbb425:
	movl $1, %eax
.Lbb426:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_45, @function
.size lex_45, .-lex_45
/* end function lex_45 */

.text
lex_44:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_45
	cmpl $0, %eax
	jnz .Lbb430
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb431
.Lbb430:
	movl $1, %eax
.Lbb431:
	popq %rbx
	leave
	ret
.type lex_44, @function
.size lex_44, .-lex_44
/* end function lex_44 */

.text
lex_bar:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_44
	cmpl $0, %eax
	jnz .Lbb434
	movl $0, %eax
	jmp .Lbb436
.Lbb434:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb436
	movq offset_ptr(%rip), %rax
.Lbb436:
	leave
	ret
.type lex_bar, @function
.size lex_bar, .-lex_bar
/* end function lex_bar */

.text
lex_47:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $46, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb440
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb441
.Lbb440:
	movl $1, %eax
.Lbb441:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_47, @function
.size lex_47, .-lex_47
/* end function lex_47 */

.text
lex_46:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_47
	cmpl $0, %eax
	jnz .Lbb445
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb446
.Lbb445:
	movl $1, %eax
.Lbb446:
	popq %rbx
	leave
	ret
.type lex_46, @function
.size lex_46, .-lex_46
/* end function lex_46 */

.text
lex_dot:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_46
	cmpl $0, %eax
	jnz .Lbb449
	movl $0, %eax
	jmp .Lbb451
.Lbb449:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb451
	movq offset_ptr(%rip), %rax
.Lbb451:
	leave
	ret
.type lex_dot, @function
.size lex_dot, .-lex_dot
/* end function lex_dot */

.text
lex_49:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $91, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb455
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb456
.Lbb455:
	movl $1, %eax
.Lbb456:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_49, @function
.size lex_49, .-lex_49
/* end function lex_49 */

.text
lex_48:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_49
	cmpl $0, %eax
	jnz .Lbb460
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb461
.Lbb460:
	movl $1, %eax
.Lbb461:
	popq %rbx
	leave
	ret
.type lex_48, @function
.size lex_48, .-lex_48
/* end function lex_48 */

.text
lex_l_bracket:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_48
	cmpl $0, %eax
	jnz .Lbb464
	movl $0, %eax
	jmp .Lbb466
.Lbb464:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb466
	movq offset_ptr(%rip), %rax
.Lbb466:
	leave
	ret
.type lex_l_bracket, @function
.size lex_l_bracket, .-lex_l_bracket
/* end function lex_l_bracket */

.text
lex_51:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $93, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb470
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb471
.Lbb470:
	movl $1, %eax
.Lbb471:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_51, @function
.size lex_51, .-lex_51
/* end function lex_51 */

.text
lex_50:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_51
	cmpl $0, %eax
	jnz .Lbb475
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb476
.Lbb475:
	movl $1, %eax
.Lbb476:
	popq %rbx
	leave
	ret
.type lex_50, @function
.size lex_50, .-lex_50
/* end function lex_50 */

.text
lex_r_bracket:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_50
	cmpl $0, %eax
	jnz .Lbb479
	movl $0, %eax
	jmp .Lbb481
.Lbb479:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb481
	movq offset_ptr(%rip), %rax
.Lbb481:
	leave
	ret
.type lex_r_bracket, @function
.size lex_r_bracket, .-lex_r_bracket
/* end function lex_r_bracket */

.text
lex_53:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $40, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb485
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb486
.Lbb485:
	movl $1, %eax
.Lbb486:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_53, @function
.size lex_53, .-lex_53
/* end function lex_53 */

.text
lex_52:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_53
	cmpl $0, %eax
	jnz .Lbb490
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb491
.Lbb490:
	movl $1, %eax
.Lbb491:
	popq %rbx
	leave
	ret
.type lex_52, @function
.size lex_52, .-lex_52
/* end function lex_52 */

.text
lex_l_paren:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_52
	cmpl $0, %eax
	jnz .Lbb494
	movl $0, %eax
	jmp .Lbb496
.Lbb494:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb496
	movq offset_ptr(%rip), %rax
.Lbb496:
	leave
	ret
.type lex_l_paren, @function
.size lex_l_paren, .-lex_l_paren
/* end function lex_l_paren */

.text
lex_55:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $41, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb500
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb501
.Lbb500:
	movl $1, %eax
.Lbb501:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_55, @function
.size lex_55, .-lex_55
/* end function lex_55 */

.text
lex_54:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_55
	cmpl $0, %eax
	jnz .Lbb505
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb506
.Lbb505:
	movl $1, %eax
.Lbb506:
	popq %rbx
	leave
	ret
.type lex_54, @function
.size lex_54, .-lex_54
/* end function lex_54 */

.text
lex_r_paren:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_54
	cmpl $0, %eax
	jnz .Lbb509
	movl $0, %eax
	jmp .Lbb511
.Lbb509:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb511
	movq offset_ptr(%rip), %rax
.Lbb511:
	leave
	ret
.type lex_r_paren, @function
.size lex_r_paren, .-lex_r_paren
/* end function lex_r_paren */

.text
lex_57:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $123, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb515
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb516
.Lbb515:
	movl $1, %eax
.Lbb516:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_57, @function
.size lex_57, .-lex_57
/* end function lex_57 */

.text
lex_56:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_57
	cmpl $0, %eax
	jnz .Lbb520
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb521
.Lbb520:
	movl $1, %eax
.Lbb521:
	popq %rbx
	leave
	ret
.type lex_56, @function
.size lex_56, .-lex_56
/* end function lex_56 */

.text
lex_l_brace:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_56
	cmpl $0, %eax
	jnz .Lbb524
	movl $0, %eax
	jmp .Lbb526
.Lbb524:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb526
	movq offset_ptr(%rip), %rax
.Lbb526:
	leave
	ret
.type lex_l_brace, @function
.size lex_l_brace, .-lex_l_brace
/* end function lex_l_brace */

.text
lex_59:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $125, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb530
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb531
.Lbb530:
	movl $1, %eax
.Lbb531:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_59, @function
.size lex_59, .-lex_59
/* end function lex_59 */

.text
lex_58:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_59
	cmpl $0, %eax
	jnz .Lbb535
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb536
.Lbb535:
	movl $1, %eax
.Lbb536:
	popq %rbx
	leave
	ret
.type lex_58, @function
.size lex_58, .-lex_58
/* end function lex_58 */

.text
lex_r_brace:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_58
	cmpl $0, %eax
	jnz .Lbb539
	movl $0, %eax
	jmp .Lbb541
.Lbb539:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb541
	movq offset_ptr(%rip), %rax
.Lbb541:
	leave
	ret
.type lex_r_brace, @function
.size lex_r_brace, .-lex_r_brace
/* end function lex_r_brace */

.text
lex_61:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $43, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb545
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb546
.Lbb545:
	movl $1, %eax
.Lbb546:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_61, @function
.size lex_61, .-lex_61
/* end function lex_61 */

.text
lex_60:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_61
	cmpl $0, %eax
	jnz .Lbb550
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb551
.Lbb550:
	movl $1, %eax
.Lbb551:
	popq %rbx
	leave
	ret
.type lex_60, @function
.size lex_60, .-lex_60
/* end function lex_60 */

.text
lex_plus:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_60
	cmpl $0, %eax
	jnz .Lbb554
	movl $0, %eax
	jmp .Lbb556
.Lbb554:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb556
	movq offset_ptr(%rip), %rax
.Lbb556:
	leave
	ret
.type lex_plus, @function
.size lex_plus, .-lex_plus
/* end function lex_plus */

.text
lex_63:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $61, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb560
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb561
.Lbb560:
	movl $1, %eax
.Lbb561:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_63, @function
.size lex_63, .-lex_63
/* end function lex_63 */

.text
lex_62:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_63
	cmpl $0, %eax
	jnz .Lbb565
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb566
.Lbb565:
	movl $1, %eax
.Lbb566:
	popq %rbx
	leave
	ret
.type lex_62, @function
.size lex_62, .-lex_62
/* end function lex_62 */

.text
lex_eq:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_62
	cmpl $0, %eax
	jnz .Lbb569
	movl $0, %eax
	jmp .Lbb571
.Lbb569:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb571
	movq offset_ptr(%rip), %rax
.Lbb571:
	leave
	ret
.type lex_eq, @function
.size lex_eq, .-lex_eq
/* end function lex_eq */

.text
lex_66:
	pushq %rbp
	movq %rsp, %rbp
	movl $95, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb574
	movl $0, %eax
	jmp .Lbb575
.Lbb574:
	callq inc_offset
	movl $1, %eax
.Lbb575:
	leave
	ret
.type lex_66, @function
.size lex_66, .-lex_66
/* end function lex_66 */

.text
lex_67:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $97, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $122, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb578
	movl $0, %eax
	jmp .Lbb579
.Lbb578:
	callq inc_offset
	movl $1, %eax
.Lbb579:
	leave
	ret
.type lex_67, @function
.size lex_67, .-lex_67
/* end function lex_67 */

.text
lex_68:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $65, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $90, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb582
	movl $0, %eax
	jmp .Lbb583
.Lbb582:
	callq inc_offset
	movl $1, %eax
.Lbb583:
	leave
	ret
.type lex_68, @function
.size lex_68, .-lex_68
/* end function lex_68 */

.text
lex_65:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_66
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb589
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_67
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb589
	movq %rbx, offset_ptr(%rip)
	callq lex_68
	cmpl $0, %eax
	jnz .Lbb589
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb590
.Lbb589:
	movl $1, %eax
.Lbb590:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_65, @function
.size lex_65, .-lex_65
/* end function lex_65 */

.text
lex_70:
	pushq %rbp
	movq %rsp, %rbp
	movl $95, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb593
	movl $0, %eax
	jmp .Lbb594
.Lbb593:
	callq inc_offset
	movl $1, %eax
.Lbb594:
	leave
	ret
.type lex_70, @function
.size lex_70, .-lex_70
/* end function lex_70 */

.text
lex_71:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $97, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $122, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb597
	movl $0, %eax
	jmp .Lbb598
.Lbb597:
	callq inc_offset
	movl $1, %eax
.Lbb598:
	leave
	ret
.type lex_71, @function
.size lex_71, .-lex_71
/* end function lex_71 */

.text
lex_72:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $65, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $90, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb601
	movl $0, %eax
	jmp .Lbb602
.Lbb601:
	callq inc_offset
	movl $1, %eax
.Lbb602:
	leave
	ret
.type lex_72, @function
.size lex_72, .-lex_72
/* end function lex_72 */

.text
lex_73:
	pushq %rbp
	movq %rsp, %rbp
	movq offset_ptr(%rip), %rax
	movzbl (%rax, %rdi, 1), %ecx
	cmpl $48, %ecx
	setae %al
	movzbl %al, %eax
	cmpl $57, %ecx
	setbe %cl
	movzbl %cl, %ecx
	testl %eax, %ecx
	jnz .Lbb605
	movl $0, %eax
	jmp .Lbb606
.Lbb605:
	callq inc_offset
	movl $1, %eax
.Lbb606:
	leave
	ret
.type lex_73, @function
.size lex_73, .-lex_73
/* end function lex_73 */

.text
lex_69:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_70
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb613
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_71
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb613
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_72
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb613
	movq %rbx, offset_ptr(%rip)
	callq lex_73
	cmpl $0, %eax
	jnz .Lbb613
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb614
.Lbb613:
	movl $1, %eax
.Lbb614:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_69, @function
.size lex_69, .-lex_69
/* end function lex_69 */

.text
lex_74:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
.Lbb616:
	movq %rsi, %r12
	movq %rdi, %rbx
	callq lex_69
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb618
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jnz .Lbb616
.Lbb618:
	movl $1, %eax
	popq %r12
	popq %rbx
	leave
	ret
.type lex_74, @function
.size lex_74, .-lex_74
/* end function lex_74 */

.text
lex_64:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_65
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb623
	callq lex_74
	cmpl $0, %eax
	jnz .Lbb624
.Lbb623:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb625
.Lbb624:
	movl $1, %eax
.Lbb625:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_64, @function
.size lex_64, .-lex_64
/* end function lex_64 */

.text
lex_ident:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_64
	cmpl $0, %eax
	jnz .Lbb628
	movl $0, %eax
	jmp .Lbb630
.Lbb628:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb630
	movq offset_ptr(%rip), %rax
.Lbb630:
	leave
	ret
.type lex_ident, @function
.size lex_ident, .-lex_ident
/* end function lex_ident */

.text
lex_76:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $59, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb634
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb635
.Lbb634:
	movl $1, %eax
.Lbb635:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_76, @function
.size lex_76, .-lex_76
/* end function lex_76 */

.text
lex_75:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_76
	cmpl $0, %eax
	jnz .Lbb639
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb640
.Lbb639:
	movl $1, %eax
.Lbb640:
	popq %rbx
	leave
	ret
.type lex_75, @function
.size lex_75, .-lex_75
/* end function lex_75 */

.text
lex_semi:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_75
	cmpl $0, %eax
	jnz .Lbb643
	movl $0, %eax
	jmp .Lbb645
.Lbb643:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb645
	movq offset_ptr(%rip), %rax
.Lbb645:
	leave
	ret
.type lex_semi, @function
.size lex_semi, .-lex_semi
/* end function lex_semi */

.text
lex_78:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $34, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb649
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb650
.Lbb649:
	movl $1, %eax
.Lbb650:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_78, @function
.size lex_78, .-lex_78
/* end function lex_78 */

.text
lex_81:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $92, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb654
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb655
.Lbb654:
	movl $1, %eax
.Lbb655:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_81, @function
.size lex_81, .-lex_81
/* end function lex_81 */

.text
lex_82:
	pushq %rbp
	movq %rsp, %rbp
	callq inc_offset
	movl $1, %eax
	leave
	ret
.type lex_82, @function
.size lex_82, .-lex_82
/* end function lex_82 */

.text
lex_80:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_81
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb661
	callq lex_82
	cmpl $0, %eax
	jnz .Lbb662
.Lbb661:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb663
.Lbb662:
	movl $1, %eax
.Lbb663:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_80, @function
.size lex_80, .-lex_80
/* end function lex_80 */

.text
lex_85:
	pushq %rbp
	movq %rsp, %rbp
	movl $34, %edx
	callq cmp_current
	cmpl $0, %eax
	jnz .Lbb666
	movl $0, %eax
	jmp .Lbb667
.Lbb666:
	callq inc_offset
	movl $1, %eax
.Lbb667:
	leave
	ret
.type lex_85, @function
.size lex_85, .-lex_85
/* end function lex_85 */

.text
lex_87:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $92, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb671
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb672
.Lbb671:
	movl $1, %eax
.Lbb672:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_87, @function
.size lex_87, .-lex_87
/* end function lex_87 */

.text
lex_86:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_87
	leave
	ret
.type lex_86, @function
.size lex_86, .-lex_86
/* end function lex_86 */

.text
lex_84:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_85
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb681
	movq %rsi, %r12
	callq lex_86
	movq %r12, %rsi
	cmpl $0, %eax
	jnz .Lbb681
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jz .Lbb680
	callq inc_offset
	movl $1, %eax
	jmp .Lbb682
.Lbb680:
	movl $1, %eax
	jmp .Lbb682
.Lbb681:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
.Lbb682:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_84, @function
.size lex_84, .-lex_84
/* end function lex_84 */

.text
lex_83:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_84
	cmpl $0, %eax
	jnz .Lbb686
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb687
.Lbb686:
	movl $1, %eax
.Lbb687:
	popq %rbx
	leave
	ret
.type lex_83, @function
.size lex_83, .-lex_83
/* end function lex_83 */

.text
lex_79:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rbx, offset_ptr(%rip)
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_80
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jnz .Lbb692
	movq %rbx, offset_ptr(%rip)
	callq lex_83
	cmpl $0, %eax
	jnz .Lbb692
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb693
.Lbb692:
	movl $1, %eax
.Lbb693:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_79, @function
.size lex_79, .-lex_79
/* end function lex_79 */

.text
lex_88:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
.Lbb695:
	movq %rsi, %r12
	movq %rdi, %rbx
	callq lex_79
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb697
	movq offset_ptr(%rip), %rax
	cmpq %rsi, %rax
	jnz .Lbb695
.Lbb697:
	movl $1, %eax
	popq %r12
	popq %rbx
	leave
	ret
.type lex_88, @function
.size lex_88, .-lex_88
/* end function lex_88 */

.text
lex_89:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $34, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb702
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb703
.Lbb702:
	movl $1, %eax
.Lbb703:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_89, @function
.size lex_89, .-lex_89
/* end function lex_89 */

.text
lex_77:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movq offset_ptr(%rip), %rbx
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_78
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb708
	movq %rsi, %r13
	movq %rdi, %r12
	callq lex_88
	movq %r13, %rsi
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb708
	callq lex_89
	cmpl $0, %eax
	jnz .Lbb709
.Lbb708:
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb710
.Lbb709:
	movl $1, %eax
.Lbb710:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex_77, @function
.size lex_77, .-lex_77
/* end function lex_77 */

.text
lex_string:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_77
	cmpl $0, %eax
	jnz .Lbb713
	movl $0, %eax
	jmp .Lbb715
.Lbb713:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb715
	movq offset_ptr(%rip), %rax
.Lbb715:
	leave
	ret
.type lex_string, @function
.size lex_string, .-lex_string
/* end function lex_string */

.text
lex_91:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movq offset_ptr(%rip), %rbx
	movl $64, %edx
	callq cmp_current
	movl %eax, %r12d
	callq inc_offset
	cmpl $0, %r12d
	jnz .Lbb719
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb720
.Lbb719:
	movl $1, %eax
.Lbb720:
	popq %r12
	popq %rbx
	leave
	ret
.type lex_91, @function
.size lex_91, .-lex_91
/* end function lex_91 */

.text
lex_90:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	movq offset_ptr(%rip), %rbx
	callq lex_91
	cmpl $0, %eax
	jnz .Lbb724
	movq %rbx, offset_ptr(%rip)
	movl $0, %eax
	jmp .Lbb725
.Lbb724:
	movl $1, %eax
.Lbb725:
	popq %rbx
	leave
	ret
.type lex_90, @function
.size lex_90, .-lex_90
/* end function lex_90 */

.text
lex_at:
	pushq %rbp
	movq %rsp, %rbp
	callq lex_90
	cmpl $0, %eax
	jnz .Lbb728
	movl $0, %eax
	jmp .Lbb730
.Lbb728:
	movq group_end(%rip), %rax
	cmpl $0, %eax
	jnz .Lbb730
	movq offset_ptr(%rip), %rax
.Lbb730:
	leave
	ret
.type lex_at, @function
.size lex_at, .-lex_at
/* end function lex_at */

.text
.globl lex
lex:
	pushq %rbp
	movq %rsp, %rbp
	subq $632, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdx, %r12
	movq %rdi, -16(%rbp)
	movq %rsi, %rbx
	movl $24, %esi
	leaq -40(%rbp), %rdi
	callq new_vec
	movq %r12, %rdx
	movq %rbx, %rsi
	movq %rax, %rbx
	movl $0, %r13d
	movl $0, %r12d
.Lbb733:
	movq %rdx, %r15
	cmpl $0, %r15d
	jz .Lbb833
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_KEYWORD
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb830
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_PARSER
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb827
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_TOKEN
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb824
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_HIGHTLIGHT
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb821
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_FOLD
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb818
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_whitespace
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb815
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_int
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb812
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_colon
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb809
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_comma
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb806
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_bar
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb803
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_dot
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb800
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_l_bracket
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb797
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_r_bracket
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb794
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_l_paren
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb791
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_r_paren
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb788
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_l_brace
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb785
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_r_brace
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb782
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_plus
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb779
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_eq
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb776
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_ident
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb773
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_semi
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb770
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_string
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb767
	movq %rsi, %r14
	movq %r15, %rsi
	movq %r14, %rdi
	callq lex_at
	movq %r15, %rdx
	movq %r14, %rsi
	movq %rax, %r14
	cmpl $0, %r14d
	jnz .Lbb764
	cmpl $0, %r13d
	jnz .Lbb760
	movq %r12, %r13
	addq $1, %r12
	movq %r12, %rcx
	movq %rdx, %r14
	movq %r13, %rdx
	movq %rsi, %r13
	movl $23, %esi
	leaq -64(%rbp), %rdi
	callq new_token
	movq %r13, %rsi
	movq %rax, %rdx
	movq %rsi, %r13
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r13, %rsi
	movq %r14, %rdx
	jmp .Lbb762
.Lbb760:
	movq %rdx, %r14
	addq $1, %r12
	movq %rsi, %r13
	movl $24, %esi
	movq %rbx, %rdi
	callq last
	movq %r14, %rdx
	movq %r13, %rsi
	movq %rax, %rcx
	movq 16(%rcx), %rax
	addq $1, %rax
	movq %rax, 16(%rcx)
.Lbb762:
	addq $1, %rsi
	subq $1, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $1, %r13d
	jmp .Lbb733
.Lbb764:
	movq %r14, %r13
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $22, %esi
	leaq -88(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb767:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $21, %esi
	leaq -112(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb770:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $20, %esi
	leaq -136(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb773:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $19, %esi
	leaq -160(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb776:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $18, %esi
	leaq -184(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb779:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $17, %esi
	leaq -208(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb782:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $16, %esi
	leaq -232(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb785:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $15, %esi
	leaq -256(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb788:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $14, %esi
	leaq -280(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb791:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $13, %esi
	leaq -304(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb794:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $12, %esi
	leaq -328(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb797:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $11, %esi
	leaq -352(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb800:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $10, %esi
	leaq -376(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb803:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $9, %esi
	leaq -400(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb806:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $8, %esi
	leaq -424(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb809:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $7, %esi
	leaq -448(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb812:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $6, %esi
	leaq -472(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb815:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $5, %esi
	leaq -496(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb818:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $4, %esi
	leaq -520(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb821:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $3, %esi
	leaq -544(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb824:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $2, %esi
	leaq -568(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb827:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $1, %esi
	leaq -592(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb830:
	movq %r14, %r13
	movq %r15, %rdx
	movq %r12, %r14
	addq %r13, %r12
	movq %r12, %rcx
	movq %rdx, %r15
	movq %r14, %rdx
	movq %rsi, %r14
	movl $0, %esi
	leaq -616(%rbp), %rdi
	callq new_token
	movq %r14, %rsi
	movq %rax, %rdx
	movq %rsi, %r14
	movl $24, %esi
	movq %rbx, %rdi
	callq push
	movq %r15, %rdx
	movq %r14, %rsi
	addq %r13, %rsi
	subq %r13, %rdx
	movq $0, offset_ptr(%rip)
	movq $0, group_end(%rip)
	movl $0, %r13d
	jmp .Lbb733
.Lbb833:
	movq -16(%rbp), %rax
	movq 0(%rbx), %rcx
	movq %rcx, 0(%rax)
	movq 8(%rbx), %rcx
	movq %rcx, 8(%rax)
	movq 16(%rbx), %rcx
	movq %rcx, 16(%rax)
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type lex, @function
.size lex, .-lex
/* end function lex */

.data
.balign 8
KEYWORD_token_name:
	.ascii "KEYWORD"
	.byte 0
/* end data */

.data
.balign 8
KEYWORD_token_name_len:
	.quad 7
/* end data */

.data
.balign 8
PARSER_token_name:
	.ascii "PARSER"
	.byte 0
/* end data */

.data
.balign 8
PARSER_token_name_len:
	.quad 6
/* end data */

.data
.balign 8
TOKEN_token_name:
	.ascii "TOKEN"
	.byte 0
/* end data */

.data
.balign 8
TOKEN_token_name_len:
	.quad 5
/* end data */

.data
.balign 8
HIGHTLIGHT_token_name:
	.ascii "HIGHTLIGHT"
	.byte 0
/* end data */

.data
.balign 8
HIGHTLIGHT_token_name_len:
	.quad 10
/* end data */

.data
.balign 8
FOLD_token_name:
	.ascii "FOLD"
	.byte 0
/* end data */

.data
.balign 8
FOLD_token_name_len:
	.quad 4
/* end data */

.data
.balign 8
whitespace_token_name:
	.ascii "whitespace"
	.byte 0
/* end data */

.data
.balign 8
whitespace_token_name_len:
	.quad 10
/* end data */

.data
.balign 8
int_token_name:
	.ascii "int"
	.byte 0
/* end data */

.data
.balign 8
int_token_name_len:
	.quad 3
/* end data */

.data
.balign 8
colon_token_name:
	.ascii "colon"
	.byte 0
/* end data */

.data
.balign 8
colon_token_name_len:
	.quad 5
/* end data */

.data
.balign 8
comma_token_name:
	.ascii "comma"
	.byte 0
/* end data */

.data
.balign 8
comma_token_name_len:
	.quad 5
/* end data */

.data
.balign 8
bar_token_name:
	.ascii "bar"
	.byte 0
/* end data */

.data
.balign 8
bar_token_name_len:
	.quad 3
/* end data */

.data
.balign 8
dot_token_name:
	.ascii "dot"
	.byte 0
/* end data */

.data
.balign 8
dot_token_name_len:
	.quad 3
/* end data */

.data
.balign 8
l_bracket_token_name:
	.ascii "l_bracket"
	.byte 0
/* end data */

.data
.balign 8
l_bracket_token_name_len:
	.quad 9
/* end data */

.data
.balign 8
r_bracket_token_name:
	.ascii "r_bracket"
	.byte 0
/* end data */

.data
.balign 8
r_bracket_token_name_len:
	.quad 9
/* end data */

.data
.balign 8
l_paren_token_name:
	.ascii "l_paren"
	.byte 0
/* end data */

.data
.balign 8
l_paren_token_name_len:
	.quad 7
/* end data */

.data
.balign 8
r_paren_token_name:
	.ascii "r_paren"
	.byte 0
/* end data */

.data
.balign 8
r_paren_token_name_len:
	.quad 7
/* end data */

.data
.balign 8
l_brace_token_name:
	.ascii "l_brace"
	.byte 0
/* end data */

.data
.balign 8
l_brace_token_name_len:
	.quad 7
/* end data */

.data
.balign 8
r_brace_token_name:
	.ascii "r_brace"
	.byte 0
/* end data */

.data
.balign 8
r_brace_token_name_len:
	.quad 7
/* end data */

.data
.balign 8
plus_token_name:
	.ascii "plus"
	.byte 0
/* end data */

.data
.balign 8
plus_token_name_len:
	.quad 4
/* end data */

.data
.balign 8
eq_token_name:
	.ascii "eq"
	.byte 0
/* end data */

.data
.balign 8
eq_token_name_len:
	.quad 2
/* end data */

.data
.balign 8
ident_token_name:
	.ascii "ident"
	.byte 0
/* end data */

.data
.balign 8
ident_token_name_len:
	.quad 5
/* end data */

.data
.balign 8
semi_token_name:
	.ascii "semi"
	.byte 0
/* end data */

.data
.balign 8
semi_token_name_len:
	.quad 4
/* end data */

.data
.balign 8
string_token_name:
	.ascii "string"
	.byte 0
/* end data */

.data
.balign 8
string_token_name_len:
	.quad 6
/* end data */

.data
.balign 8
at_token_name:
	.ascii "at"
	.byte 0
/* end data */

.data
.balign 8
at_token_name_len:
	.quad 2
/* end data */

.data
.balign 8
err_token_name:
	.ascii "token_error"
	.byte 0
/* end data */

.text
.globl token_name
token_name:
	pushq %rbp
	movq %rsp, %rbp
	cmpl $0, %edi
	leaq KEYWORD_token_name(%rip), %rax
	jz .Lbb883
	cmpl $1, %edi
	leaq PARSER_token_name(%rip), %rax
	jz .Lbb882
	cmpl $2, %edi
	leaq TOKEN_token_name(%rip), %rax
	jz .Lbb881
	cmpl $3, %edi
	leaq HIGHTLIGHT_token_name(%rip), %rax
	jz .Lbb880
	cmpl $4, %edi
	leaq FOLD_token_name(%rip), %rax
	jz .Lbb879
	cmpl $5, %edi
	leaq whitespace_token_name(%rip), %rax
	jz .Lbb878
	cmpl $6, %edi
	leaq int_token_name(%rip), %rax
	jz .Lbb877
	cmpl $7, %edi
	leaq colon_token_name(%rip), %rax
	jz .Lbb876
	cmpl $8, %edi
	leaq comma_token_name(%rip), %rax
	jz .Lbb875
	cmpl $9, %edi
	leaq bar_token_name(%rip), %rax
	jz .Lbb874
	cmpl $10, %edi
	leaq dot_token_name(%rip), %rax
	jz .Lbb873
	cmpl $11, %edi
	leaq l_bracket_token_name(%rip), %rax
	jz .Lbb872
	cmpl $12, %edi
	leaq r_bracket_token_name(%rip), %rax
	jz .Lbb871
	cmpl $13, %edi
	leaq l_paren_token_name(%rip), %rax
	jz .Lbb870
	cmpl $14, %edi
	leaq r_paren_token_name(%rip), %rax
	jz .Lbb869
	cmpl $15, %edi
	leaq l_brace_token_name(%rip), %rax
	jz .Lbb868
	cmpl $16, %edi
	leaq r_brace_token_name(%rip), %rax
	jz .Lbb867
	cmpl $17, %edi
	leaq plus_token_name(%rip), %rax
	jz .Lbb866
	cmpl $18, %edi
	leaq eq_token_name(%rip), %rax
	jz .Lbb865
	cmpl $19, %edi
	leaq ident_token_name(%rip), %rax
	jz .Lbb864
	cmpl $20, %edi
	leaq semi_token_name(%rip), %rax
	jz .Lbb863
	cmpl $21, %edi
	leaq string_token_name(%rip), %rax
	jz .Lbb862
	cmpl $22, %edi
	leaq at_token_name(%rip), %rax
	jz .Lbb861
	leaq err_token_name(%rip), %rax
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb884
.Lbb861:
	movq %rax, %rdx
	movl $2, %eax
	jmp .Lbb884
.Lbb862:
	movq %rax, %rdx
	movl $6, %eax
	jmp .Lbb884
.Lbb863:
	movq %rax, %rdx
	movl $4, %eax
	jmp .Lbb884
.Lbb864:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb884
.Lbb865:
	movq %rax, %rdx
	movl $2, %eax
	jmp .Lbb884
.Lbb866:
	movq %rax, %rdx
	movl $4, %eax
	jmp .Lbb884
.Lbb867:
	movq %rax, %rdx
	movl $7, %eax
	jmp .Lbb884
.Lbb868:
	movq %rax, %rdx
	movl $7, %eax
	jmp .Lbb884
.Lbb869:
	movq %rax, %rdx
	movl $7, %eax
	jmp .Lbb884
.Lbb870:
	movq %rax, %rdx
	movl $7, %eax
	jmp .Lbb884
.Lbb871:
	movq %rax, %rdx
	movl $9, %eax
	jmp .Lbb884
.Lbb872:
	movq %rax, %rdx
	movl $9, %eax
	jmp .Lbb884
.Lbb873:
	movq %rax, %rdx
	movl $3, %eax
	jmp .Lbb884
.Lbb874:
	movq %rax, %rdx
	movl $3, %eax
	jmp .Lbb884
.Lbb875:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb884
.Lbb876:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb884
.Lbb877:
	movq %rax, %rdx
	movl $3, %eax
	jmp .Lbb884
.Lbb878:
	movq %rax, %rdx
	movl $10, %eax
	jmp .Lbb884
.Lbb879:
	movq %rax, %rdx
	movl $4, %eax
	jmp .Lbb884
.Lbb880:
	movq %rax, %rdx
	movl $10, %eax
	jmp .Lbb884
.Lbb881:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb884
.Lbb882:
	movq %rax, %rdx
	movl $6, %eax
	jmp .Lbb884
.Lbb883:
	movq %rax, %rdx
	movl $7, %eax
.Lbb884:
	subq $16, %rsp
	movq %rsp, %rcx
	movq %rdx, (%rcx)
	movq %rax, 8(%rcx)
	movq (%rcx), %rax
	movq 8(%rcx), %rdx
	movq %rbp, %rsp
	subq $0, %rsp
	leave
	ret
.type token_name, @function
.size token_name, .-token_name
/* end function token_name */

.text
peak_by_id:
	pushq %rbp
	movq %rsp, %rbp
	cmpq $0, %rcx
	jz .Lbb1032
	cmpq $1, %rcx
	jz .Lbb1031
	cmpq $2, %rcx
	jz .Lbb1030
	cmpq $3, %rcx
	jz .Lbb1029
	cmpq $4, %rcx
	jz .Lbb1028
	cmpq $5, %rcx
	jz .Lbb1027
	cmpq $6, %rcx
	jz .Lbb1026
	cmpq $7, %rcx
	jz .Lbb1025
	cmpq $8, %rcx
	jz .Lbb1024
	cmpq $9, %rcx
	jz .Lbb1023
	cmpq $10, %rcx
	jz .Lbb1022
	cmpq $11, %rcx
	jz .Lbb1021
	cmpq $12, %rcx
	jz .Lbb1020
	cmpq $13, %rcx
	jz .Lbb1019
	cmpq $14, %rcx
	jz .Lbb1018
	cmpq $15, %rcx
	jz .Lbb1017
	cmpq $16, %rcx
	jz .Lbb1016
	cmpq $17, %rcx
	jz .Lbb1015
	cmpq $18, %rcx
	jz .Lbb1014
	cmpq $19, %rcx
	jz .Lbb1013
	cmpq $20, %rcx
	jz .Lbb1012
	cmpq $21, %rcx
	jz .Lbb1011
	cmpq $22, %rcx
	jz .Lbb1010
	cmpq $23, %rcx
	jz .Lbb1009
	cmpq $24, %rcx
	jz .Lbb1008
	cmpq $25, %rcx
	jz .Lbb1007
	cmpq $26, %rcx
	jz .Lbb1006
	cmpq $27, %rcx
	jz .Lbb1005
	cmpq $28, %rcx
	jz .Lbb1004
	cmpq $29, %rcx
	jz .Lbb1003
	cmpq $30, %rcx
	jz .Lbb1002
	cmpq $31, %rcx
	jz .Lbb1001
	cmpq $32, %rcx
	jz .Lbb1000
	cmpq $33, %rcx
	jz .Lbb999
	cmpq $34, %rcx
	jz .Lbb998
	cmpq $35, %rcx
	jz .Lbb997
	cmpq $36, %rcx
	jz .Lbb996
	cmpq $37, %rcx
	jz .Lbb995
	cmpq $38, %rcx
	jz .Lbb994
	cmpq $39, %rcx
	jz .Lbb993
	cmpq $40, %rcx
	jz .Lbb992
	cmpq $41, %rcx
	jz .Lbb991
	cmpq $42, %rcx
	jz .Lbb990
	cmpq $43, %rcx
	jz .Lbb989
	cmpq $44, %rcx
	jz .Lbb988
	cmpq $45, %rcx
	jz .Lbb987
	cmpq $46, %rcx
	jz .Lbb986
	cmpq $47, %rcx
	jz .Lbb985
	cmpq $48, %rcx
	jz .Lbb984
	cmpq $49, %rcx
	jz .Lbb983
	cmpq $50, %rcx
	jz .Lbb982
	cmpq $51, %rcx
	jz .Lbb981
	cmpq $52, %rcx
	jz .Lbb980
	cmpq $53, %rcx
	jz .Lbb979
	cmpq $54, %rcx
	jz .Lbb978
	cmpq $55, %rcx
	jz .Lbb977
	cmpq $56, %rcx
	jz .Lbb976
	cmpq $57, %rcx
	jz .Lbb975
	cmpq $58, %rcx
	jz .Lbb974
	cmpq $59, %rcx
	jz .Lbb973
	cmpq $60, %rcx
	jz .Lbb972
	cmpq $61, %rcx
	jz .Lbb971
	cmpq $62, %rcx
	jz .Lbb970
	cmpq $63, %rcx
	jz .Lbb969
	cmpq $64, %rcx
	jz .Lbb968
	cmpq $65, %rcx
	jz .Lbb967
	cmpq $66, %rcx
	jz .Lbb966
	cmpq $67, %rcx
	jz .Lbb965
	cmpq $68, %rcx
	jz .Lbb964
	cmpq $69, %rcx
	jz .Lbb963
	cmpq $70, %rcx
	jz .Lbb962
	cmpq $71, %rcx
	jz .Lbb961
	cmpq $72, %rcx
	jz .Lbb960
	movl $0, %eax
	jmp .Lbb1033
.Lbb960:
	callq peak_72
	jmp .Lbb1033
.Lbb961:
	callq peak_71
	jmp .Lbb1033
.Lbb962:
	callq peak_70
	jmp .Lbb1033
.Lbb963:
	callq peak_69
	jmp .Lbb1033
.Lbb964:
	callq peak_68
	jmp .Lbb1033
.Lbb965:
	callq peak_67
	jmp .Lbb1033
.Lbb966:
	callq peak_66
	jmp .Lbb1033
.Lbb967:
	callq peak_65
	jmp .Lbb1033
.Lbb968:
	callq peak_64
	jmp .Lbb1033
.Lbb969:
	callq peak_63
	jmp .Lbb1033
.Lbb970:
	callq peak_62
	jmp .Lbb1033
.Lbb971:
	callq peak_61
	jmp .Lbb1033
.Lbb972:
	callq peak_60
	jmp .Lbb1033
.Lbb973:
	callq peak_59
	jmp .Lbb1033
.Lbb974:
	callq peak_58
	jmp .Lbb1033
.Lbb975:
	callq peak_57
	jmp .Lbb1033
.Lbb976:
	callq peak_56
	jmp .Lbb1033
.Lbb977:
	callq peak_55
	jmp .Lbb1033
.Lbb978:
	callq peak_54
	jmp .Lbb1033
.Lbb979:
	callq peak_53
	jmp .Lbb1033
.Lbb980:
	callq peak_52
	jmp .Lbb1033
.Lbb981:
	callq peak_51
	jmp .Lbb1033
.Lbb982:
	callq peak_50
	jmp .Lbb1033
.Lbb983:
	callq peak_49
	jmp .Lbb1033
.Lbb984:
	callq peak_48
	jmp .Lbb1033
.Lbb985:
	callq peak_47
	jmp .Lbb1033
.Lbb986:
	callq peak_46
	jmp .Lbb1033
.Lbb987:
	callq peak_45
	jmp .Lbb1033
.Lbb988:
	callq peak_44
	jmp .Lbb1033
.Lbb989:
	callq peak_43
	jmp .Lbb1033
.Lbb990:
	callq peak_42
	jmp .Lbb1033
.Lbb991:
	callq peak_41
	jmp .Lbb1033
.Lbb992:
	callq peak_40
	jmp .Lbb1033
.Lbb993:
	callq peak_39
	jmp .Lbb1033
.Lbb994:
	callq peak_38
	jmp .Lbb1033
.Lbb995:
	callq peak_37
	jmp .Lbb1033
.Lbb996:
	callq peak_36
	jmp .Lbb1033
.Lbb997:
	callq peak_35
	jmp .Lbb1033
.Lbb998:
	callq peak_34
	jmp .Lbb1033
.Lbb999:
	callq peak_33
	jmp .Lbb1033
.Lbb1000:
	callq peak_32
	jmp .Lbb1033
.Lbb1001:
	callq peak_31
	jmp .Lbb1033
.Lbb1002:
	callq peak_30
	jmp .Lbb1033
.Lbb1003:
	callq peak_29
	jmp .Lbb1033
.Lbb1004:
	callq peak_28
	jmp .Lbb1033
.Lbb1005:
	callq peak_27
	jmp .Lbb1033
.Lbb1006:
	callq peak_26
	jmp .Lbb1033
.Lbb1007:
	callq peak_25
	jmp .Lbb1033
.Lbb1008:
	callq peak_24
	jmp .Lbb1033
.Lbb1009:
	callq peak_23
	jmp .Lbb1033
.Lbb1010:
	callq peak_22
	jmp .Lbb1033
.Lbb1011:
	callq peak_21
	jmp .Lbb1033
.Lbb1012:
	callq peak_20
	jmp .Lbb1033
.Lbb1013:
	callq peak_19
	jmp .Lbb1033
.Lbb1014:
	callq peak_18
	jmp .Lbb1033
.Lbb1015:
	callq peak_17
	jmp .Lbb1033
.Lbb1016:
	callq peak_16
	jmp .Lbb1033
.Lbb1017:
	callq peak_15
	jmp .Lbb1033
.Lbb1018:
	callq peak_14
	jmp .Lbb1033
.Lbb1019:
	callq peak_13
	jmp .Lbb1033
.Lbb1020:
	callq peak_12
	jmp .Lbb1033
.Lbb1021:
	callq peak_11
	jmp .Lbb1033
.Lbb1022:
	callq peak_10
	jmp .Lbb1033
.Lbb1023:
	callq peak_9
	jmp .Lbb1033
.Lbb1024:
	callq peak_8
	jmp .Lbb1033
.Lbb1025:
	callq peak_7
	jmp .Lbb1033
.Lbb1026:
	callq peak_6
	jmp .Lbb1033
.Lbb1027:
	callq peak_5
	jmp .Lbb1033
.Lbb1028:
	callq peak_4
	jmp .Lbb1033
.Lbb1029:
	callq peak_3
	jmp .Lbb1033
.Lbb1030:
	callq peak_2
	jmp .Lbb1033
.Lbb1031:
	callq peak_1
	jmp .Lbb1033
.Lbb1032:
	callq peak_0
.Lbb1033:
	leave
	ret
.type peak_by_id, @function
.size peak_by_id, .-peak_by_id
/* end function peak_by_id */

.text
parse_0:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $8, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_23
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1038
	movq %rdi, %rbx
	callq parse_26
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1037
	callq exit_group
	movq %rbx, %rax
	jmp .Lbb1039
.Lbb1037:
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	movq %rdi, %r12
	callq pop
	movq %r12, %rdi
	movl $32, %esi
	callq last
	movq %rax, %r12
	movq 16(%rbx), %rax
	movq 8(%rbx), %r15
	imulq $32, %rax, %rdx
	movq %rdx, -24(%rbp)
	movq 16(%r12), %rcx
	movq 8(%r12), %rdi
	imulq $32, %rcx, %r14
	movq %rax, %r13
	addq %rcx, %r13
	imulq $2, %r13, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rbx
	imulq $64, %r13, %rdi
	callq malloc
	movq %r14, %rdx
	movq %rbx, %rdi
	movq %rax, %r14
	movq %r14, %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	movq %rdi, %rsi
	movq %rdi, %rbx
	movq %r14, %rdi
	callq memcpy
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rdx
	movq %r15, %rsi
	callq memcpy
	movq %rbx, %rdi
	movq -32(%rbp), %rbx
	callq free
	movq %r15, %rdi
	callq free
	movq %r14, 8(%r12)
	movq %r13, 16(%r12)
	movq %rbx, 24(%r12)
	movl $0, %eax
	jmp .Lbb1039
.Lbb1038:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1039:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_0, @function
.size parse_0, .-parse_0
/* end function parse_0 */

.text
peak_0:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_23
	leave
	ret
.type peak_0, @function
.size peak_0, .-peak_0
/* end function peak_0 */

.data
.balign 8
expected_0_data:
	.quad 0
	.quad 13
	.quad 1
	.quad 1
/* end data */

.text
expected_0:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $32, %edi
	callq malloc
	movq %rax, %rbx
	movl $32, %edx
	leaq expected_0_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $2, -16(%rbp)
	movq $2, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_0, @function
.size expected_0, .-expected_0
/* end function expected_0 */

.text
parse_1:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1045:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1057
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $19, %rsi
	jz .Lbb1056
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1050
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1045
.Lbb1050:
	cmpl $0, %r12d
	jz .Lbb1055
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1055
.Lbb1052:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1054
	cmpl $0, %ebx
	jz .Lbb1055
	jmp .Lbb1052
.Lbb1054:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1058
.Lbb1055:
	movl $1, %eax
	jmp .Lbb1058
.Lbb1056:
	callq bump
	movl $0, %eax
	jmp .Lbb1058
.Lbb1057:
	movl $2, %eax
.Lbb1058:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_1, @function
.size parse_1, .-parse_1
/* end function parse_1 */

.text
peak_1:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1068
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $19, %rax
	jz .Lbb1067
	cmpl $0, %edx
	jz .Lbb1066
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1066
.Lbb1063:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1065
	cmpl $0, %ebx
	jz .Lbb1066
	jmp .Lbb1063
.Lbb1065:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1069
.Lbb1066:
	movl $1, %eax
	jmp .Lbb1069
.Lbb1067:
	movl $0, %eax
	jmp .Lbb1069
.Lbb1068:
	movl $2, %eax
.Lbb1069:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_1, @function
.size peak_1, .-peak_1
/* end function peak_1 */

.data
.balign 8
expected_1_data:
	.quad 0
	.quad 19
/* end data */

.text
expected_1:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_1_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_1, @function
.size expected_1, .-expected_1
/* end function expected_1 */

.text
parse_2:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $1, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_1
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1074
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb1075
.Lbb1074:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1075:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_2, @function
.size parse_2, .-parse_2
/* end function parse_2 */

.text
peak_2:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_1
	leave
	ret
.type peak_2, @function
.size peak_2, .-peak_2
/* end function peak_2 */

.data
.balign 8
expected_2_data:
	.quad 1
	.quad 1
/* end data */

.text
expected_2:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_2_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_2, @function
.size expected_2, .-expected_2
/* end function expected_2 */

.text
parse_3:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1081:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1093
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $13, %rsi
	jz .Lbb1092
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1086
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1081
.Lbb1086:
	cmpl $0, %r12d
	jz .Lbb1091
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1091
.Lbb1088:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1090
	cmpl $0, %ebx
	jz .Lbb1091
	jmp .Lbb1088
.Lbb1090:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1094
.Lbb1091:
	movl $1, %eax
	jmp .Lbb1094
.Lbb1092:
	callq bump
	movl $0, %eax
	jmp .Lbb1094
.Lbb1093:
	movl $2, %eax
.Lbb1094:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_3, @function
.size parse_3, .-parse_3
/* end function parse_3 */

.text
peak_3:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1104
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $13, %rax
	jz .Lbb1103
	cmpl $0, %edx
	jz .Lbb1102
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1102
.Lbb1099:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1101
	cmpl $0, %ebx
	jz .Lbb1102
	jmp .Lbb1099
.Lbb1101:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1105
.Lbb1102:
	movl $1, %eax
	jmp .Lbb1105
.Lbb1103:
	movl $0, %eax
	jmp .Lbb1105
.Lbb1104:
	movl $2, %eax
.Lbb1105:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_3, @function
.size peak_3, .-peak_3
/* end function peak_3 */

.data
.balign 8
expected_3_data:
	.quad 0
	.quad 13
/* end data */

.text
expected_3:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_3_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_3, @function
.size expected_3, .-expected_3
/* end function expected_3 */

.text
parse_4:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1109:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1121
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $14, %rsi
	jz .Lbb1120
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1114
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1109
.Lbb1114:
	cmpl $0, %r12d
	jz .Lbb1119
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1119
.Lbb1116:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1118
	cmpl $0, %ebx
	jz .Lbb1119
	jmp .Lbb1116
.Lbb1118:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1122
.Lbb1119:
	movl $1, %eax
	jmp .Lbb1122
.Lbb1120:
	callq bump
	movl $0, %eax
	jmp .Lbb1122
.Lbb1121:
	movl $2, %eax
.Lbb1122:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_4, @function
.size parse_4, .-parse_4
/* end function parse_4 */

.text
peak_4:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1132
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $14, %rax
	jz .Lbb1131
	cmpl $0, %edx
	jz .Lbb1130
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1130
.Lbb1127:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1129
	cmpl $0, %ebx
	jz .Lbb1130
	jmp .Lbb1127
.Lbb1129:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1133
.Lbb1130:
	movl $1, %eax
	jmp .Lbb1133
.Lbb1131:
	movl $0, %eax
	jmp .Lbb1133
.Lbb1132:
	movl $2, %eax
.Lbb1133:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_4, @function
.size peak_4, .-peak_4
/* end function peak_4 */

.data
.balign 8
expected_4_data:
	.quad 0
	.quad 14
/* end data */

.text
expected_4:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_4_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_4, @function
.size expected_4, .-expected_4
/* end function expected_4 */

.text
parse_5:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_3
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1152
	movl %esi, %r14d
	movl $4, %esi
	movq %rdi, %rbx
	callq push_delim
	movq %rbx, %rdi
	movq %rax, %rbx
	movl %r14d, %esi
.Lbb1139:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_0
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1142
	movl %esi, %r13d
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1139
.Lbb1142:
	movl %esi, %r14d
	cmpl $0, %r12d
	jnz .Lbb1145
	movl %r14d, %esi
	jmp .Lbb1146
.Lbb1145:
	movq %rdi, %r13
	leaq -48(%rbp), %rdi
	callq expected_0
	movq %r13, %rdi
	movq %rax, %rsi
	movq %rdi, %r13
	callq missing
	movl %r14d, %esi
	movq %r13, %rdi
	cmpq %r12, %rbx
	jnz .Lbb1150
.Lbb1146:
	movl %esi, %r13d
	movq %rdi, %rbx
	callq parse_4
	movq %rbx, %rdi
	cmpq $1, %rax
	jnz .Lbb1149
	movq %rdi, %rbx
	callq bump_err
	movq %rbx, %rdi
	movl %r13d, %esi
	jmp .Lbb1146
.Lbb1149:
	cmpl $0, %eax
	jz .Lbb1151
.Lbb1150:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_4
	movq %rbx, %rdi
	movq %rax, %rsi
	movq %rdi, %rbx
	callq missing
	movq %rbx, %rdi
.Lbb1151:
	callq pop_delim
	movl $0, %eax
.Lbb1152:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_5, @function
.size parse_5, .-parse_5
/* end function parse_5 */

.text
peak_5:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_3
	leave
	ret
.type peak_5, @function
.size peak_5, .-peak_5
/* end function peak_5 */

.data
.balign 8
expected_5_data:
	.quad 0
	.quad 13
/* end data */

.text
expected_5:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_5_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_5, @function
.size expected_5, .-expected_5
/* end function expected_5 */

.text
parse_6:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_5
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1159
	callq parse_2
.Lbb1159:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_6, @function
.size parse_6, .-parse_6
/* end function parse_6 */

.text
peak_6:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r13d
	movq %rsi, %r12
	movq %rdi, %rbx
	callq peak_5
	movl %r13d, %edx
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1162
	callq peak_2
.Lbb1162:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_6, @function
.size peak_6, .-peak_6
/* end function peak_6 */

.data
.balign 8
expected_6_data:
	.quad 0
	.quad 13
	.quad 1
	.quad 1
/* end data */

.text
expected_6:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $32, %edi
	callq malloc
	movq %rax, %rbx
	movl $32, %edx
	leaq expected_6_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $2, -16(%rbp)
	movq $2, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_6, @function
.size expected_6, .-expected_6
/* end function expected_6 */

.text
parse_7:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1166:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1178
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $19, %rsi
	jz .Lbb1177
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1171
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1166
.Lbb1171:
	cmpl $0, %r12d
	jz .Lbb1176
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1176
.Lbb1173:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1175
	cmpl $0, %ebx
	jz .Lbb1176
	jmp .Lbb1173
.Lbb1175:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1179
.Lbb1176:
	movl $1, %eax
	jmp .Lbb1179
.Lbb1177:
	callq bump
	movl $0, %eax
	jmp .Lbb1179
.Lbb1178:
	movl $2, %eax
.Lbb1179:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_7, @function
.size parse_7, .-parse_7
/* end function parse_7 */

.text
peak_7:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1189
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $19, %rax
	jz .Lbb1188
	cmpl $0, %edx
	jz .Lbb1187
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1187
.Lbb1184:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1186
	cmpl $0, %ebx
	jz .Lbb1187
	jmp .Lbb1184
.Lbb1186:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1190
.Lbb1187:
	movl $1, %eax
	jmp .Lbb1190
.Lbb1188:
	movl $0, %eax
	jmp .Lbb1190
.Lbb1189:
	movl $2, %eax
.Lbb1190:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_7, @function
.size peak_7, .-peak_7
/* end function peak_7 */

.data
.balign 8
expected_7_data:
	.quad 0
	.quad 19
/* end data */

.text
expected_7:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_7_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_7, @function
.size expected_7, .-expected_7
/* end function expected_7 */

.text
parse_8:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $3, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_7
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1195
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb1196
.Lbb1195:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1196:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_8, @function
.size parse_8, .-parse_8
/* end function parse_8 */

.text
peak_8:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_7
	leave
	ret
.type peak_8, @function
.size peak_8, .-peak_8
/* end function peak_8 */

.data
.balign 8
expected_8_data:
	.quad 1
	.quad 3
/* end data */

.text
expected_8:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_8_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_8, @function
.size expected_8, .-expected_8
/* end function expected_8 */

.text
parse_9:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1202:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1214
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $8, %rsi
	jz .Lbb1213
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1207
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1202
.Lbb1207:
	cmpl $0, %r12d
	jz .Lbb1212
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1212
.Lbb1209:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1211
	cmpl $0, %ebx
	jz .Lbb1212
	jmp .Lbb1209
.Lbb1211:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1215
.Lbb1212:
	movl $1, %eax
	jmp .Lbb1215
.Lbb1213:
	callq bump
	movl $0, %eax
	jmp .Lbb1215
.Lbb1214:
	movl $2, %eax
.Lbb1215:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_9, @function
.size parse_9, .-parse_9
/* end function parse_9 */

.text
peak_9:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1225
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $8, %rax
	jz .Lbb1224
	cmpl $0, %edx
	jz .Lbb1223
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1223
.Lbb1220:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1222
	cmpl $0, %ebx
	jz .Lbb1223
	jmp .Lbb1220
.Lbb1222:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1226
.Lbb1223:
	movl $1, %eax
	jmp .Lbb1226
.Lbb1224:
	movl $0, %eax
	jmp .Lbb1226
.Lbb1225:
	movl $2, %eax
.Lbb1226:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_9, @function
.size peak_9, .-peak_9
/* end function peak_9 */

.data
.balign 8
expected_9_data:
	.quad 0
	.quad 8
/* end data */

.text
expected_9:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_9_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_9, @function
.size expected_9, .-expected_9
/* end function expected_9 */

.text
parse_10:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $0, %esi
	movq %rdi, %rbx
	callq push_delim
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	movl %esi, %r13d
	movl $9, %esi
	movq %rdi, %r12
	callq push_delim
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_0
	movl %r14d, %esi
	movq %r13, %rdi
	cmpl $0, %eax
	jnz .Lbb1246
.Lbb1230:
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_9
	movq %r13, %rdi
	cmpq $1, %rax
	jz .Lbb1245
	cmpl $0, %eax
	jnz .Lbb1233
	movl %r14d, %esi
	jmp .Lbb1237
.Lbb1233:
	cmpq $2, %rax
	jz .Lbb1244
	cmpq %rax, %rbx
	jnz .Lbb1244
	movq %rdi, %r13
	leaq -48(%rbp), %rdi
	callq expected_9
	movq %r13, %rdi
	movq %rax, %rsi
	movq %rdi, %r13
	callq missing
	movq %r13, %rdi
	movl %r14d, %esi
.Lbb1237:
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_0
	movq %r13, %rdi
	movq %rax, %r13
	cmpq $1, %r13
	jnz .Lbb1239
	movq %rdi, %r13
	callq bump_err
	movl %r14d, %esi
	movq %r13, %rdi
	jmp .Lbb1237
.Lbb1239:
	cmpl $0, %r13d
	jnz .Lbb1241
	movl %r14d, %esi
	jmp .Lbb1230
.Lbb1241:
	movq %rdi, %r15
	leaq -24(%rbp), %rdi
	callq expected_0
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	cmpq $2, %r13
	jz .Lbb1244
	cmpq %r13, %r12
	jnz .Lbb1244
	movl %r14d, %esi
	jmp .Lbb1230
.Lbb1244:
	callq pop_delim
	movl $0, %eax
	jmp .Lbb1248
.Lbb1245:
	movq %rdi, %r13
	callq bump_err
	movl %r14d, %esi
	movq %r13, %rdi
	jmp .Lbb1230
.Lbb1246:
	movq %rax, %rbx
	callq pop_delim
	movq %rbx, %rax
.Lbb1248:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_10, @function
.size parse_10, .-parse_10
/* end function parse_10 */

.text
peak_10:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_0
	leave
	ret
.type peak_10, @function
.size peak_10, .-peak_10
/* end function peak_10 */

.data
.balign 8
expected_10_data:
	.quad 0
	.quad 13
	.quad 1
	.quad 1
/* end data */

.text
expected_10:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $32, %edi
	callq malloc
	movq %rax, %rbx
	movl $32, %edx
	leaq expected_10_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $2, -16(%rbp)
	movq $2, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_10, @function
.size expected_10, .-expected_10
/* end function expected_10 */

.text
parse_11:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1254:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1266
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $13, %rsi
	jz .Lbb1265
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1259
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1254
.Lbb1259:
	cmpl $0, %r12d
	jz .Lbb1264
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1264
.Lbb1261:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1263
	cmpl $0, %ebx
	jz .Lbb1264
	jmp .Lbb1261
.Lbb1263:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1267
.Lbb1264:
	movl $1, %eax
	jmp .Lbb1267
.Lbb1265:
	callq bump
	movl $0, %eax
	jmp .Lbb1267
.Lbb1266:
	movl $2, %eax
.Lbb1267:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_11, @function
.size parse_11, .-parse_11
/* end function parse_11 */

.text
peak_11:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1277
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $13, %rax
	jz .Lbb1276
	cmpl $0, %edx
	jz .Lbb1275
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1275
.Lbb1272:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1274
	cmpl $0, %ebx
	jz .Lbb1275
	jmp .Lbb1272
.Lbb1274:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1278
.Lbb1275:
	movl $1, %eax
	jmp .Lbb1278
.Lbb1276:
	movl $0, %eax
	jmp .Lbb1278
.Lbb1277:
	movl $2, %eax
.Lbb1278:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_11, @function
.size peak_11, .-peak_11
/* end function peak_11 */

.data
.balign 8
expected_11_data:
	.quad 0
	.quad 13
/* end data */

.text
expected_11:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_11_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_11, @function
.size expected_11, .-expected_11
/* end function expected_11 */

.text
parse_12:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1282:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1294
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $14, %rsi
	jz .Lbb1293
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1287
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1282
.Lbb1287:
	cmpl $0, %r12d
	jz .Lbb1292
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1292
.Lbb1289:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1291
	cmpl $0, %ebx
	jz .Lbb1292
	jmp .Lbb1289
.Lbb1291:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1295
.Lbb1292:
	movl $1, %eax
	jmp .Lbb1295
.Lbb1293:
	callq bump
	movl $0, %eax
	jmp .Lbb1295
.Lbb1294:
	movl $2, %eax
.Lbb1295:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_12, @function
.size parse_12, .-parse_12
/* end function parse_12 */

.text
peak_12:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1305
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $14, %rax
	jz .Lbb1304
	cmpl $0, %edx
	jz .Lbb1303
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1303
.Lbb1300:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1302
	cmpl $0, %ebx
	jz .Lbb1303
	jmp .Lbb1300
.Lbb1302:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1306
.Lbb1303:
	movl $1, %eax
	jmp .Lbb1306
.Lbb1304:
	movl $0, %eax
	jmp .Lbb1306
.Lbb1305:
	movl $2, %eax
.Lbb1306:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_12, @function
.size peak_12, .-peak_12
/* end function peak_12 */

.data
.balign 8
expected_12_data:
	.quad 0
	.quad 14
/* end data */

.text
expected_12:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_12_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_12, @function
.size expected_12, .-expected_12
/* end function expected_12 */

.text
parse_13:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_11
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1325
	movl %esi, %r14d
	movl $12, %esi
	movq %rdi, %rbx
	callq push_delim
	movq %rbx, %rdi
	movq %rax, %rbx
	movl %r14d, %esi
.Lbb1312:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_10
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1315
	movl %esi, %r13d
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1312
.Lbb1315:
	movl %esi, %r14d
	cmpl $0, %r12d
	jnz .Lbb1318
	movl %r14d, %esi
	jmp .Lbb1319
.Lbb1318:
	movq %rdi, %r13
	leaq -48(%rbp), %rdi
	callq expected_10
	movq %r13, %rdi
	movq %rax, %rsi
	movq %rdi, %r13
	callq missing
	movl %r14d, %esi
	movq %r13, %rdi
	cmpq %r12, %rbx
	jnz .Lbb1323
.Lbb1319:
	movl %esi, %r13d
	movq %rdi, %rbx
	callq parse_12
	movq %rbx, %rdi
	cmpq $1, %rax
	jnz .Lbb1322
	movq %rdi, %rbx
	callq bump_err
	movq %rbx, %rdi
	movl %r13d, %esi
	jmp .Lbb1319
.Lbb1322:
	cmpl $0, %eax
	jz .Lbb1324
.Lbb1323:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_12
	movq %rbx, %rdi
	movq %rax, %rsi
	movq %rdi, %rbx
	callq missing
	movq %rbx, %rdi
.Lbb1324:
	callq pop_delim
	movl $0, %eax
.Lbb1325:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_13, @function
.size parse_13, .-parse_13
/* end function parse_13 */

.text
peak_13:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_11
	leave
	ret
.type peak_13, @function
.size peak_13, .-peak_13
/* end function peak_13 */

.data
.balign 8
expected_13_data:
	.quad 0
	.quad 13
/* end data */

.text
expected_13:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_13_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_13, @function
.size expected_13, .-expected_13
/* end function expected_13 */

.text
parse_14:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $4, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_13
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1332
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb1333
.Lbb1332:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1333:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_14, @function
.size parse_14, .-parse_14
/* end function parse_14 */

.text
peak_14:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_13
	leave
	ret
.type peak_14, @function
.size peak_14, .-peak_14
/* end function peak_14 */

.data
.balign 8
expected_14_data:
	.quad 1
	.quad 4
/* end data */

.text
expected_14:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_14_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_14, @function
.size expected_14, .-expected_14
/* end function expected_14 */

.text
parse_15:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1339:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1351
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $10, %rsi
	jz .Lbb1350
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1344
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1339
.Lbb1344:
	cmpl $0, %r12d
	jz .Lbb1349
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1349
.Lbb1346:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1348
	cmpl $0, %ebx
	jz .Lbb1349
	jmp .Lbb1346
.Lbb1348:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1352
.Lbb1349:
	movl $1, %eax
	jmp .Lbb1352
.Lbb1350:
	callq bump
	movl $0, %eax
	jmp .Lbb1352
.Lbb1351:
	movl $2, %eax
.Lbb1352:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_15, @function
.size parse_15, .-parse_15
/* end function parse_15 */

.text
peak_15:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1362
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $10, %rax
	jz .Lbb1361
	cmpl $0, %edx
	jz .Lbb1360
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1360
.Lbb1357:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1359
	cmpl $0, %ebx
	jz .Lbb1360
	jmp .Lbb1357
.Lbb1359:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1363
.Lbb1360:
	movl $1, %eax
	jmp .Lbb1363
.Lbb1361:
	movl $0, %eax
	jmp .Lbb1363
.Lbb1362:
	movl $2, %eax
.Lbb1363:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_15, @function
.size peak_15, .-peak_15
/* end function peak_15 */

.data
.balign 8
expected_15_data:
	.quad 0
	.quad 10
/* end data */

.text
expected_15:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_15_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_15, @function
.size expected_15, .-expected_15
/* end function expected_15 */

.text
parse_16:
	pushq %rbp
	movq %rsp, %rbp
	subq $136, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	movq %r12, %rdi
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $5, %rbx
	movl %esi, %r14d
	movl $14, %esi
	movq %rdi, %r13
	callq push_long
	movl %r14d, %esi
	movq %r13, %rdi
	movl %esi, %r13d
	movl $8, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_15
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb1395
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1370
	movl %r13d, %esi
	jmp .Lbb1376
.Lbb1370:
	cmpq $2, %rax
	jz .Lbb1374
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -120(%rbp), %rdi
	callq expected_15
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1373
	movl %r13d, %esi
	jmp .Lbb1376
.Lbb1373:
	movq %rax, %r12
	jmp .Lbb1380
.Lbb1374:
	movq %rdi, %r12
	leaq -96(%rbp), %rdi
	callq expected_15
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movq %r12, %rdi
	movl %r13d, %esi
.Lbb1376:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_8
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1379
	movl %esi, %r13d
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1376
.Lbb1379:
	movl %esi, %r13d
.Lbb1380:
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1382
	movl %r13d, %esi
	jmp .Lbb1386
.Lbb1382:
	cmpq $2, %rax
	jz .Lbb1385
	movq %rax, %r14
	movq %rbx, %rax
	subq $2, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_8
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1390
	movl %r13d, %esi
	jmp .Lbb1386
.Lbb1385:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_8
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb1386:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_14
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1389
	movq %rdi, %r12
	callq bump_err
	movq %r12, %rdi
	movl %r13d, %esi
	jmp .Lbb1386
.Lbb1389:
	movq %r12, %rax
.Lbb1390:
	cmpl $0, %eax
	jz .Lbb1394
	cmpq $2, %rax
	jz .Lbb1393
	movq %rbx, %rcx
	subq $2, %rcx
	cmpq %rcx, %rax
	jz .Lbb1394
.Lbb1393:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_14
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb1394:
	movl $0, %eax
	jmp .Lbb1396
.Lbb1395:
	movq %r12, %rax
.Lbb1396:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_16, @function
.size parse_16, .-parse_16
/* end function parse_16 */

.text
peak_16:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_15
	leave
	ret
.type peak_16, @function
.size peak_16, .-peak_16
/* end function peak_16 */

.data
.balign 8
expected_16_data:
	.quad 0
	.quad 10
/* end data */

.text
expected_16:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_16_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_16, @function
.size expected_16, .-expected_16
/* end function expected_16 */

.text
parse_17:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $5, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_16
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1403
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb1404
.Lbb1403:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1404:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_17, @function
.size parse_17, .-parse_17
/* end function parse_17 */

.text
peak_17:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_16
	leave
	ret
.type peak_17, @function
.size peak_17, .-peak_17
/* end function peak_17 */

.data
.balign 8
expected_17_data:
	.quad 1
	.quad 5
/* end data */

.text
expected_17:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_17_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_17, @function
.size expected_17, .-expected_17
/* end function expected_17 */

.text
parse_18:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $17, %esi
	movq %rdi, %rbx
	callq push_delim
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_17
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1416
	movq %rdi, %rbx
	callq is_eof
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1415
.Lbb1411:
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_17
	movq %rbx, %rdi
	cmpq $1, %rax
	jz .Lbb1414
	cmpl $0, %eax
	jnz .Lbb1415
	movl %r12d, %esi
	jmp .Lbb1411
.Lbb1414:
	movq %rdi, %rbx
	callq bump_err
	movl %r12d, %esi
	movq %rbx, %rdi
	jmp .Lbb1411
.Lbb1415:
	callq pop_delim
	movl $0, %eax
	jmp .Lbb1417
.Lbb1416:
	callq pop_delim
	movq %rbx, %rax
.Lbb1417:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_18, @function
.size parse_18, .-parse_18
/* end function parse_18 */

.text
peak_18:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_17
	leave
	ret
.type peak_18, @function
.size peak_18, .-peak_18
/* end function peak_18 */

.data
.balign 8
expected_18_data:
	.quad 1
	.quad 5
/* end data */

.text
expected_18:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_18_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_18, @function
.size expected_18, .-expected_18
/* end function expected_18 */

.text
parse_19:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $6, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_6
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1426
	movq %rdi, %rbx
	callq parse_18
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1425
	callq exit_group
	movq %rbx, %rax
	jmp .Lbb1427
.Lbb1425:
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	movq %rdi, %r12
	callq pop
	movq %r12, %rdi
	movl $32, %esi
	callq last
	movq %rax, %r12
	movq 16(%rbx), %rax
	movq 8(%rbx), %r15
	imulq $32, %rax, %rdx
	movq %rdx, -24(%rbp)
	movq 16(%r12), %rcx
	movq 8(%r12), %rdi
	imulq $32, %rcx, %r14
	movq %rax, %r13
	addq %rcx, %r13
	imulq $2, %r13, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rbx
	imulq $64, %r13, %rdi
	callq malloc
	movq %r14, %rdx
	movq %rbx, %rdi
	movq %rax, %r14
	movq %r14, %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	movq %rdi, %rsi
	movq %rdi, %rbx
	movq %r14, %rdi
	callq memcpy
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rdx
	movq %r15, %rsi
	callq memcpy
	movq %rbx, %rdi
	movq -32(%rbp), %rbx
	callq free
	movq %r15, %rdi
	callq free
	movq %r14, 8(%r12)
	movq %r13, 16(%r12)
	movq %rbx, 24(%r12)
	movl $0, %eax
	jmp .Lbb1427
.Lbb1426:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1427:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_19, @function
.size parse_19, .-parse_19
/* end function parse_19 */

.text
peak_19:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_6
	leave
	ret
.type peak_19, @function
.size peak_19, .-peak_19
/* end function peak_19 */

.data
.balign 8
expected_19_data:
	.quad 0
	.quad 13
	.quad 1
	.quad 1
/* end data */

.text
expected_19:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $32, %edi
	callq malloc
	movq %rax, %rbx
	movl $32, %edx
	leaq expected_19_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $2, -16(%rbp)
	movq $2, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_19, @function
.size expected_19, .-expected_19
/* end function expected_19 */

.text
parse_20:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1433:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1445
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $17, %rsi
	jz .Lbb1444
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1438
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1433
.Lbb1438:
	cmpl $0, %r12d
	jz .Lbb1443
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1443
.Lbb1440:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1442
	cmpl $0, %ebx
	jz .Lbb1443
	jmp .Lbb1440
.Lbb1442:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1446
.Lbb1443:
	movl $1, %eax
	jmp .Lbb1446
.Lbb1444:
	callq bump
	movl $0, %eax
	jmp .Lbb1446
.Lbb1445:
	movl $2, %eax
.Lbb1446:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_20, @function
.size parse_20, .-parse_20
/* end function parse_20 */

.text
peak_20:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1456
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $17, %rax
	jz .Lbb1455
	cmpl $0, %edx
	jz .Lbb1454
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1454
.Lbb1451:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1453
	cmpl $0, %ebx
	jz .Lbb1454
	jmp .Lbb1451
.Lbb1453:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1457
.Lbb1454:
	movl $1, %eax
	jmp .Lbb1457
.Lbb1455:
	movl $0, %eax
	jmp .Lbb1457
.Lbb1456:
	movl $2, %eax
.Lbb1457:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_20, @function
.size peak_20, .-peak_20
/* end function peak_20 */

.data
.balign 8
expected_20_data:
	.quad 0
	.quad 17
/* end data */

.text
expected_20:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_20_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_20, @function
.size expected_20, .-expected_20
/* end function expected_20 */

.text
parse_21:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $19, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_20
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb1476
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1464
	movl %r13d, %esi
	jmp .Lbb1468
.Lbb1464:
	cmpq $2, %rax
	jz .Lbb1467
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_20
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1471
	movl %r13d, %esi
	jmp .Lbb1468
.Lbb1467:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_20
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb1468:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_19
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1470
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1468
.Lbb1470:
	movq %r12, %rax
.Lbb1471:
	cmpl $0, %eax
	jz .Lbb1475
	cmpq $2, %rax
	jz .Lbb1474
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb1475
.Lbb1474:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_19
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb1475:
	movl $0, %eax
	jmp .Lbb1477
.Lbb1476:
	movq %r12, %rax
.Lbb1477:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_21, @function
.size parse_21, .-parse_21
/* end function parse_21 */

.text
peak_21:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_20
	leave
	ret
.type peak_21, @function
.size peak_21, .-peak_21
/* end function peak_21 */

.data
.balign 8
expected_21_data:
	.quad 0
	.quad 17
/* end data */

.text
expected_21:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_21_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_21, @function
.size expected_21, .-expected_21
/* end function expected_21 */

.text
parse_22:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $21, %esi
	movq %rdi, %rbx
	callq push_delim
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_21
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1489
	movq %rdi, %rbx
	callq is_eof
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1488
.Lbb1484:
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_21
	movq %rbx, %rdi
	cmpq $1, %rax
	jz .Lbb1487
	cmpl $0, %eax
	jnz .Lbb1488
	movl %r12d, %esi
	jmp .Lbb1484
.Lbb1487:
	movq %rdi, %rbx
	callq bump_err
	movl %r12d, %esi
	movq %rbx, %rdi
	jmp .Lbb1484
.Lbb1488:
	callq pop_delim
	movl $0, %eax
	jmp .Lbb1490
.Lbb1489:
	callq pop_delim
	movq %rbx, %rax
.Lbb1490:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_22, @function
.size parse_22, .-parse_22
/* end function parse_22 */

.text
peak_22:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_21
	leave
	ret
.type peak_22, @function
.size peak_22, .-peak_22
/* end function peak_22 */

.data
.balign 8
expected_22_data:
	.quad 0
	.quad 17
/* end data */

.text
expected_22:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_22_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_22, @function
.size expected_22, .-expected_22
/* end function expected_22 */

.text
parse_23:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $7, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_19
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1499
	movq %rdi, %rbx
	callq parse_22
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1498
	callq exit_group
	movq %rbx, %rax
	jmp .Lbb1500
.Lbb1498:
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	movq %rdi, %r12
	callq pop
	movq %r12, %rdi
	movl $32, %esi
	callq last
	movq %rax, %r12
	movq 16(%rbx), %rax
	movq 8(%rbx), %r15
	imulq $32, %rax, %rdx
	movq %rdx, -24(%rbp)
	movq 16(%r12), %rcx
	movq 8(%r12), %rdi
	imulq $32, %rcx, %r14
	movq %rax, %r13
	addq %rcx, %r13
	imulq $2, %r13, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rbx
	imulq $64, %r13, %rdi
	callq malloc
	movq %r14, %rdx
	movq %rbx, %rdi
	movq %rax, %r14
	movq %r14, %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	movq %rdi, %rsi
	movq %rdi, %rbx
	movq %r14, %rdi
	callq memcpy
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rdx
	movq %r15, %rsi
	callq memcpy
	movq %rbx, %rdi
	movq -32(%rbp), %rbx
	callq free
	movq %r15, %rdi
	callq free
	movq %r14, 8(%r12)
	movq %r13, 16(%r12)
	movq %rbx, 24(%r12)
	movl $0, %eax
	jmp .Lbb1500
.Lbb1499:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1500:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_23, @function
.size parse_23, .-parse_23
/* end function parse_23 */

.text
peak_23:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_19
	leave
	ret
.type peak_23, @function
.size peak_23, .-peak_23
/* end function peak_23 */

.data
.balign 8
expected_23_data:
	.quad 0
	.quad 13
	.quad 1
	.quad 1
/* end data */

.text
expected_23:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $32, %edi
	callq malloc
	movq %rax, %rbx
	movl $32, %edx
	leaq expected_23_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $2, -16(%rbp)
	movq $2, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_23, @function
.size expected_23, .-expected_23
/* end function expected_23 */

.text
parse_24:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1506:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1518
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $9, %rsi
	jz .Lbb1517
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1511
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1506
.Lbb1511:
	cmpl $0, %r12d
	jz .Lbb1516
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1516
.Lbb1513:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1515
	cmpl $0, %ebx
	jz .Lbb1516
	jmp .Lbb1513
.Lbb1515:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1519
.Lbb1516:
	movl $1, %eax
	jmp .Lbb1519
.Lbb1517:
	callq bump
	movl $0, %eax
	jmp .Lbb1519
.Lbb1518:
	movl $2, %eax
.Lbb1519:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_24, @function
.size parse_24, .-parse_24
/* end function parse_24 */

.text
peak_24:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1529
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $9, %rax
	jz .Lbb1528
	cmpl $0, %edx
	jz .Lbb1527
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1527
.Lbb1524:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1526
	cmpl $0, %ebx
	jz .Lbb1527
	jmp .Lbb1524
.Lbb1526:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1530
.Lbb1527:
	movl $1, %eax
	jmp .Lbb1530
.Lbb1528:
	movl $0, %eax
	jmp .Lbb1530
.Lbb1529:
	movl $2, %eax
.Lbb1530:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_24, @function
.size peak_24, .-peak_24
/* end function peak_24 */

.data
.balign 8
expected_24_data:
	.quad 0
	.quad 9
/* end data */

.text
expected_24:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_24_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_24, @function
.size expected_24, .-expected_24
/* end function expected_24 */

.text
parse_25:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $23, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_24
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb1549
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1537
	movl %r13d, %esi
	jmp .Lbb1541
.Lbb1537:
	cmpq $2, %rax
	jz .Lbb1540
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_24
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1544
	movl %r13d, %esi
	jmp .Lbb1541
.Lbb1540:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_24
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb1541:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_23
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1543
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1541
.Lbb1543:
	movq %r12, %rax
.Lbb1544:
	cmpl $0, %eax
	jz .Lbb1548
	cmpq $2, %rax
	jz .Lbb1547
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb1548
.Lbb1547:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_23
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb1548:
	movl $0, %eax
	jmp .Lbb1550
.Lbb1549:
	movq %r12, %rax
.Lbb1550:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_25, @function
.size parse_25, .-parse_25
/* end function parse_25 */

.text
peak_25:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_24
	leave
	ret
.type peak_25, @function
.size peak_25, .-peak_25
/* end function peak_25 */

.data
.balign 8
expected_25_data:
	.quad 0
	.quad 9
/* end data */

.text
expected_25:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_25_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_25, @function
.size expected_25, .-expected_25
/* end function expected_25 */

.text
parse_26:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $25, %esi
	movq %rdi, %rbx
	callq push_delim
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_25
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1562
	movq %rdi, %rbx
	callq is_eof
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1561
.Lbb1557:
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_25
	movq %rbx, %rdi
	cmpq $1, %rax
	jz .Lbb1560
	cmpl $0, %eax
	jnz .Lbb1561
	movl %r12d, %esi
	jmp .Lbb1557
.Lbb1560:
	movq %rdi, %rbx
	callq bump_err
	movl %r12d, %esi
	movq %rbx, %rdi
	jmp .Lbb1557
.Lbb1561:
	callq pop_delim
	movl $0, %eax
	jmp .Lbb1563
.Lbb1562:
	callq pop_delim
	movq %rbx, %rax
.Lbb1563:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_26, @function
.size parse_26, .-parse_26
/* end function parse_26 */

.text
peak_26:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_25
	leave
	ret
.type peak_26, @function
.size peak_26, .-peak_26
/* end function peak_26 */

.data
.balign 8
expected_26_data:
	.quad 0
	.quad 9
/* end data */

.text
expected_26:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_26_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_26, @function
.size expected_26, .-expected_26
/* end function expected_26 */

.text
parse_27:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $8, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_23
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1572
	movq %rdi, %rbx
	callq parse_26
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1571
	callq exit_group
	movq %rbx, %rax
	jmp .Lbb1573
.Lbb1571:
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	movq %rdi, %r12
	callq pop
	movq %r12, %rdi
	movl $32, %esi
	callq last
	movq %rax, %r12
	movq 16(%rbx), %rax
	movq 8(%rbx), %r15
	imulq $32, %rax, %rdx
	movq %rdx, -24(%rbp)
	movq 16(%r12), %rcx
	movq 8(%r12), %rdi
	imulq $32, %rcx, %r14
	movq %rax, %r13
	addq %rcx, %r13
	imulq $2, %r13, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rbx
	imulq $64, %r13, %rdi
	callq malloc
	movq %r14, %rdx
	movq %rbx, %rdi
	movq %rax, %r14
	movq %r14, %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	movq %rdi, %rsi
	movq %rdi, %rbx
	movq %r14, %rdi
	callq memcpy
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rdx
	movq %r15, %rsi
	callq memcpy
	movq %rbx, %rdi
	movq -32(%rbp), %rbx
	callq free
	movq %r15, %rdi
	callq free
	movq %r14, 8(%r12)
	movq %r13, 16(%r12)
	movq %rbx, 24(%r12)
	movl $0, %eax
	jmp .Lbb1573
.Lbb1572:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1573:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_27, @function
.size parse_27, .-parse_27
/* end function parse_27 */

.text
peak_27:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_23
	leave
	ret
.type peak_27, @function
.size peak_27, .-peak_27
/* end function peak_27 */

.data
.balign 8
expected_27_data:
	.quad 0
	.quad 13
	.quad 1
	.quad 1
/* end data */

.text
expected_27:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $32, %edi
	callq malloc
	movq %rax, %rbx
	movl $32, %edx
	leaq expected_27_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $2, -16(%rbp)
	movq $2, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_27, @function
.size expected_27, .-expected_27
/* end function expected_27 */

.text
parse_28:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1579:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1591
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $0, %rsi
	jz .Lbb1590
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1584
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1579
.Lbb1584:
	cmpl $0, %r12d
	jz .Lbb1589
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1589
.Lbb1586:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1588
	cmpl $0, %ebx
	jz .Lbb1589
	jmp .Lbb1586
.Lbb1588:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1592
.Lbb1589:
	movl $1, %eax
	jmp .Lbb1592
.Lbb1590:
	callq bump
	movl $0, %eax
	jmp .Lbb1592
.Lbb1591:
	movl $2, %eax
.Lbb1592:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_28, @function
.size parse_28, .-parse_28
/* end function parse_28 */

.text
peak_28:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1602
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $0, %rax
	jz .Lbb1601
	cmpl $0, %edx
	jz .Lbb1600
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1600
.Lbb1597:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1599
	cmpl $0, %ebx
	jz .Lbb1600
	jmp .Lbb1597
.Lbb1599:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1603
.Lbb1600:
	movl $1, %eax
	jmp .Lbb1603
.Lbb1601:
	movl $0, %eax
	jmp .Lbb1603
.Lbb1602:
	movl $2, %eax
.Lbb1603:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_28, @function
.size peak_28, .-peak_28
/* end function peak_28 */

.data
.balign 8
expected_28_data:
	.quad 0
	.quad 0
/* end data */

.text
expected_28:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_28_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_28, @function
.size expected_28, .-expected_28
/* end function expected_28 */

.text
parse_29:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1607:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1619
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $19, %rsi
	jz .Lbb1618
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1612
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1607
.Lbb1612:
	cmpl $0, %r12d
	jz .Lbb1617
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1617
.Lbb1614:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1616
	cmpl $0, %ebx
	jz .Lbb1617
	jmp .Lbb1614
.Lbb1616:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1620
.Lbb1617:
	movl $1, %eax
	jmp .Lbb1620
.Lbb1618:
	callq bump
	movl $0, %eax
	jmp .Lbb1620
.Lbb1619:
	movl $2, %eax
.Lbb1620:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_29, @function
.size parse_29, .-parse_29
/* end function parse_29 */

.text
peak_29:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1630
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $19, %rax
	jz .Lbb1629
	cmpl $0, %edx
	jz .Lbb1628
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1628
.Lbb1625:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1627
	cmpl $0, %ebx
	jz .Lbb1628
	jmp .Lbb1625
.Lbb1627:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1631
.Lbb1628:
	movl $1, %eax
	jmp .Lbb1631
.Lbb1629:
	movl $0, %eax
	jmp .Lbb1631
.Lbb1630:
	movl $2, %eax
.Lbb1631:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_29, @function
.size peak_29, .-peak_29
/* end function peak_29 */

.data
.balign 8
expected_29_data:
	.quad 0
	.quad 19
/* end data */

.text
expected_29:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_29_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_29, @function
.size expected_29, .-expected_29
/* end function expected_29 */

.text
parse_30:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $29, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_28
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb1650
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1638
	movl %r13d, %esi
	jmp .Lbb1642
.Lbb1638:
	cmpq $2, %rax
	jz .Lbb1641
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_28
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1645
	movl %r13d, %esi
	jmp .Lbb1642
.Lbb1641:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_28
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb1642:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_29
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1644
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1642
.Lbb1644:
	movq %r12, %rax
.Lbb1645:
	cmpl $0, %eax
	jz .Lbb1649
	cmpq $2, %rax
	jz .Lbb1648
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb1649
.Lbb1648:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_29
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb1649:
	movl $0, %eax
	jmp .Lbb1651
.Lbb1650:
	movq %r12, %rax
.Lbb1651:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_30, @function
.size parse_30, .-parse_30
/* end function parse_30 */

.text
peak_30:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_28
	leave
	ret
.type peak_30, @function
.size peak_30, .-peak_30
/* end function peak_30 */

.data
.balign 8
expected_30_data:
	.quad 0
	.quad 0
/* end data */

.text
expected_30:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_30_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_30, @function
.size expected_30, .-expected_30
/* end function expected_30 */

.text
parse_31:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $9, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_30
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1658
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb1659
.Lbb1658:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1659:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_31, @function
.size parse_31, .-parse_31
/* end function parse_31 */

.text
peak_31:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_30
	leave
	ret
.type peak_31, @function
.size peak_31, .-peak_31
/* end function peak_31 */

.data
.balign 8
expected_31_data:
	.quad 1
	.quad 9
/* end data */

.text
expected_31:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_31_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_31, @function
.size expected_31, .-expected_31
/* end function expected_31 */

.text
parse_32:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1665:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1677
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $2, %rsi
	jz .Lbb1676
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1670
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1665
.Lbb1670:
	cmpl $0, %r12d
	jz .Lbb1675
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1675
.Lbb1672:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1674
	cmpl $0, %ebx
	jz .Lbb1675
	jmp .Lbb1672
.Lbb1674:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1678
.Lbb1675:
	movl $1, %eax
	jmp .Lbb1678
.Lbb1676:
	callq bump
	movl $0, %eax
	jmp .Lbb1678
.Lbb1677:
	movl $2, %eax
.Lbb1678:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_32, @function
.size parse_32, .-parse_32
/* end function parse_32 */

.text
peak_32:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1688
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $2, %rax
	jz .Lbb1687
	cmpl $0, %edx
	jz .Lbb1686
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1686
.Lbb1683:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1685
	cmpl $0, %ebx
	jz .Lbb1686
	jmp .Lbb1683
.Lbb1685:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1689
.Lbb1686:
	movl $1, %eax
	jmp .Lbb1689
.Lbb1687:
	movl $0, %eax
	jmp .Lbb1689
.Lbb1688:
	movl $2, %eax
.Lbb1689:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_32, @function
.size peak_32, .-peak_32
/* end function peak_32 */

.data
.balign 8
expected_32_data:
	.quad 0
	.quad 2
/* end data */

.text
expected_32:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_32_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_32, @function
.size expected_32, .-expected_32
/* end function expected_32 */

.text
parse_33:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1693:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1705
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $19, %rsi
	jz .Lbb1704
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1698
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1693
.Lbb1698:
	cmpl $0, %r12d
	jz .Lbb1703
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1703
.Lbb1700:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1702
	cmpl $0, %ebx
	jz .Lbb1703
	jmp .Lbb1700
.Lbb1702:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1706
.Lbb1703:
	movl $1, %eax
	jmp .Lbb1706
.Lbb1704:
	callq bump
	movl $0, %eax
	jmp .Lbb1706
.Lbb1705:
	movl $2, %eax
.Lbb1706:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_33, @function
.size parse_33, .-parse_33
/* end function parse_33 */

.text
peak_33:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1716
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $19, %rax
	jz .Lbb1715
	cmpl $0, %edx
	jz .Lbb1714
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1714
.Lbb1711:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1713
	cmpl $0, %ebx
	jz .Lbb1714
	jmp .Lbb1711
.Lbb1713:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1717
.Lbb1714:
	movl $1, %eax
	jmp .Lbb1717
.Lbb1715:
	movl $0, %eax
	jmp .Lbb1717
.Lbb1716:
	movl $2, %eax
.Lbb1717:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_33, @function
.size peak_33, .-peak_33
/* end function peak_33 */

.data
.balign 8
expected_33_data:
	.quad 0
	.quad 19
/* end data */

.text
expected_33:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_33_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_33, @function
.size expected_33, .-expected_33
/* end function expected_33 */

.text
parse_34:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1721:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1733
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $18, %rsi
	jz .Lbb1732
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1726
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1721
.Lbb1726:
	cmpl $0, %r12d
	jz .Lbb1731
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1731
.Lbb1728:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1730
	cmpl $0, %ebx
	jz .Lbb1731
	jmp .Lbb1728
.Lbb1730:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1734
.Lbb1731:
	movl $1, %eax
	jmp .Lbb1734
.Lbb1732:
	callq bump
	movl $0, %eax
	jmp .Lbb1734
.Lbb1733:
	movl $2, %eax
.Lbb1734:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_34, @function
.size parse_34, .-parse_34
/* end function parse_34 */

.text
peak_34:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1744
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $18, %rax
	jz .Lbb1743
	cmpl $0, %edx
	jz .Lbb1742
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1742
.Lbb1739:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1741
	cmpl $0, %ebx
	jz .Lbb1742
	jmp .Lbb1739
.Lbb1741:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1745
.Lbb1742:
	movl $1, %eax
	jmp .Lbb1745
.Lbb1743:
	movl $0, %eax
	jmp .Lbb1745
.Lbb1744:
	movl $2, %eax
.Lbb1745:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_34, @function
.size peak_34, .-peak_34
/* end function peak_34 */

.data
.balign 8
expected_34_data:
	.quad 0
	.quad 18
/* end data */

.text
expected_34:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_34_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_34, @function
.size expected_34, .-expected_34
/* end function expected_34 */

.text
parse_35:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1749:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1761
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $21, %rsi
	jz .Lbb1760
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1754
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1749
.Lbb1754:
	cmpl $0, %r12d
	jz .Lbb1759
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1759
.Lbb1756:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1758
	cmpl $0, %ebx
	jz .Lbb1759
	jmp .Lbb1756
.Lbb1758:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1762
.Lbb1759:
	movl $1, %eax
	jmp .Lbb1762
.Lbb1760:
	callq bump
	movl $0, %eax
	jmp .Lbb1762
.Lbb1761:
	movl $2, %eax
.Lbb1762:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_35, @function
.size parse_35, .-parse_35
/* end function parse_35 */

.text
peak_35:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1772
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $21, %rax
	jz .Lbb1771
	cmpl $0, %edx
	jz .Lbb1770
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1770
.Lbb1767:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1769
	cmpl $0, %ebx
	jz .Lbb1770
	jmp .Lbb1767
.Lbb1769:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1773
.Lbb1770:
	movl $1, %eax
	jmp .Lbb1773
.Lbb1771:
	movl $0, %eax
	jmp .Lbb1773
.Lbb1772:
	movl $2, %eax
.Lbb1773:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_35, @function
.size peak_35, .-peak_35
/* end function peak_35 */

.data
.balign 8
expected_35_data:
	.quad 0
	.quad 21
/* end data */

.text
expected_35:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_35_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_35, @function
.size expected_35, .-expected_35
/* end function expected_35 */

.text
parse_36:
	pushq %rbp
	movq %rsp, %rbp
	subq $184, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	movq %r12, %rdi
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $6, %rbx
	movl %esi, %r14d
	movl $35, %esi
	movq %rdi, %r13
	callq push_long
	movl %r14d, %esi
	movq %r13, %rdi
	movl %esi, %r14d
	movl $34, %esi
	movq %rdi, %r13
	callq push_long
	movl %r14d, %esi
	movq %r13, %rdi
	movl %esi, %r13d
	movl $33, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_32
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb1814
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1780
	movl %r13d, %esi
	jmp .Lbb1786
.Lbb1780:
	cmpq $2, %rax
	jz .Lbb1784
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -168(%rbp), %rdi
	callq expected_32
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1783
	movl %r13d, %esi
	jmp .Lbb1786
.Lbb1783:
	movq %rax, %r12
	jmp .Lbb1790
.Lbb1784:
	movq %rdi, %r12
	leaq -144(%rbp), %rdi
	callq expected_32
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movq %r12, %rdi
	movl %r13d, %esi
.Lbb1786:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_33
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1789
	movl %esi, %r13d
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1786
.Lbb1789:
	movl %esi, %r13d
.Lbb1790:
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jz .Lbb1795
	cmpq $2, %rax
	jz .Lbb1794
	movq %rax, %r14
	movq %rbx, %rax
	subq $2, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -120(%rbp), %rdi
	callq expected_33
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jnz .Lbb1795
	movq %rax, %r12
	jmp .Lbb1799
.Lbb1794:
	movq %rdi, %r12
	leaq -96(%rbp), %rdi
	callq expected_33
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movq %r12, %rdi
.Lbb1795:
	movl %r13d, %esi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_34
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1798
	movl %esi, %r13d
	movq %rdi, %r12
	callq bump_err
	movq %r12, %rdi
	jmp .Lbb1795
.Lbb1798:
	movl %esi, %r13d
.Lbb1799:
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1801
	movl %r13d, %esi
	jmp .Lbb1805
.Lbb1801:
	cmpq $2, %rax
	jz .Lbb1804
	movq %rax, %r14
	movq %rbx, %rax
	subq $3, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_34
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1809
	movl %r13d, %esi
	jmp .Lbb1805
.Lbb1804:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_34
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb1805:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_35
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1808
	movq %rdi, %r12
	callq bump_err
	movq %r12, %rdi
	movl %r13d, %esi
	jmp .Lbb1805
.Lbb1808:
	movq %r12, %rax
.Lbb1809:
	cmpl $0, %eax
	jz .Lbb1813
	cmpq $2, %rax
	jz .Lbb1812
	movq %rbx, %rcx
	subq $3, %rcx
	cmpq %rcx, %rax
	jz .Lbb1813
.Lbb1812:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_35
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb1813:
	movl $0, %eax
	jmp .Lbb1815
.Lbb1814:
	movq %r12, %rax
.Lbb1815:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_36, @function
.size parse_36, .-parse_36
/* end function parse_36 */

.text
peak_36:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_32
	leave
	ret
.type peak_36, @function
.size peak_36, .-peak_36
/* end function peak_36 */

.data
.balign 8
expected_36_data:
	.quad 0
	.quad 2
/* end data */

.text
expected_36:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_36_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_36, @function
.size expected_36, .-expected_36
/* end function expected_36 */

.text
parse_37:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $10, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_36
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1822
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb1823
.Lbb1822:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1823:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_37, @function
.size parse_37, .-parse_37
/* end function parse_37 */

.text
peak_37:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_36
	leave
	ret
.type peak_37, @function
.size peak_37, .-peak_37
/* end function peak_37 */

.data
.balign 8
expected_37_data:
	.quad 1
	.quad 10
/* end data */

.text
expected_37:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_37_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_37, @function
.size expected_37, .-expected_37
/* end function expected_37 */

.text
parse_38:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1829:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1841
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $4, %rsi
	jz .Lbb1840
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1834
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1829
.Lbb1834:
	cmpl $0, %r12d
	jz .Lbb1839
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1839
.Lbb1836:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1838
	cmpl $0, %ebx
	jz .Lbb1839
	jmp .Lbb1836
.Lbb1838:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1842
.Lbb1839:
	movl $1, %eax
	jmp .Lbb1842
.Lbb1840:
	callq bump
	movl $0, %eax
	jmp .Lbb1842
.Lbb1841:
	movl $2, %eax
.Lbb1842:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_38, @function
.size parse_38, .-parse_38
/* end function parse_38 */

.text
peak_38:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1852
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $4, %rax
	jz .Lbb1851
	cmpl $0, %edx
	jz .Lbb1850
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1850
.Lbb1847:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1849
	cmpl $0, %ebx
	jz .Lbb1850
	jmp .Lbb1847
.Lbb1849:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1853
.Lbb1850:
	movl $1, %eax
	jmp .Lbb1853
.Lbb1851:
	movl $0, %eax
	jmp .Lbb1853
.Lbb1852:
	movl $2, %eax
.Lbb1853:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_38, @function
.size peak_38, .-peak_38
/* end function peak_38 */

.data
.balign 8
expected_38_data:
	.quad 0
	.quad 4
/* end data */

.text
expected_38:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_38_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_38, @function
.size expected_38, .-expected_38
/* end function expected_38 */

.text
parse_39:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $0, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_38
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb1872
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1860
	movl %r13d, %esi
	jmp .Lbb1864
.Lbb1860:
	cmpq $2, %rax
	jz .Lbb1863
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_38
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1867
	movl %r13d, %esi
	jmp .Lbb1864
.Lbb1863:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_38
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb1864:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_0
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1866
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1864
.Lbb1866:
	movq %r12, %rax
.Lbb1867:
	cmpl $0, %eax
	jz .Lbb1871
	cmpq $2, %rax
	jz .Lbb1870
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb1871
.Lbb1870:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_0
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb1871:
	movl $0, %eax
	jmp .Lbb1873
.Lbb1872:
	movq %r12, %rax
.Lbb1873:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_39, @function
.size parse_39, .-parse_39
/* end function parse_39 */

.text
peak_39:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_38
	leave
	ret
.type peak_39, @function
.size peak_39, .-peak_39
/* end function peak_39 */

.data
.balign 8
expected_39_data:
	.quad 0
	.quad 4
/* end data */

.text
expected_39:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_39_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_39, @function
.size expected_39, .-expected_39
/* end function expected_39 */

.text
parse_40:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $11, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_0
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1882
	movq %rdi, %rbx
	callq parse_39
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb1881
	callq exit_group
	movq %rbx, %rax
	jmp .Lbb1883
.Lbb1881:
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	movq %rdi, %r12
	callq pop
	movq %r12, %rdi
	movl $32, %esi
	callq last
	movq %rax, %r12
	movq 16(%rbx), %rax
	movq 8(%rbx), %r15
	imulq $32, %rax, %rdx
	movq %rdx, -24(%rbp)
	movq 16(%r12), %rcx
	movq 8(%r12), %rdi
	imulq $32, %rcx, %r14
	movq %rax, %r13
	addq %rcx, %r13
	imulq $2, %r13, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rbx
	imulq $64, %r13, %rdi
	callq malloc
	movq %r14, %rdx
	movq %rbx, %rdi
	movq %rax, %r14
	movq %r14, %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	movq %rdi, %rsi
	movq %rdi, %rbx
	movq %r14, %rdi
	callq memcpy
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rdx
	movq %r15, %rsi
	callq memcpy
	movq %rbx, %rdi
	movq -32(%rbp), %rbx
	callq free
	movq %r15, %rdi
	callq free
	movq %r14, 8(%r12)
	movq %r13, 16(%r12)
	movq %rbx, 24(%r12)
	movl $0, %eax
	jmp .Lbb1883
.Lbb1882:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb1883:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_40, @function
.size parse_40, .-parse_40
/* end function parse_40 */

.text
peak_40:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_0
	leave
	ret
.type peak_40, @function
.size peak_40, .-peak_40
/* end function peak_40 */

.data
.balign 8
expected_40_data:
	.quad 0
	.quad 13
	.quad 1
	.quad 1
/* end data */

.text
expected_40:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $32, %edi
	callq malloc
	movq %rax, %rbx
	movl $32, %edx
	leaq expected_40_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $2, -16(%rbp)
	movq $2, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_40, @function
.size expected_40, .-expected_40
/* end function expected_40 */

.text
parse_41:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1889:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1901
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $1, %rsi
	jz .Lbb1900
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1894
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1889
.Lbb1894:
	cmpl $0, %r12d
	jz .Lbb1899
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1899
.Lbb1896:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1898
	cmpl $0, %ebx
	jz .Lbb1899
	jmp .Lbb1896
.Lbb1898:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1902
.Lbb1899:
	movl $1, %eax
	jmp .Lbb1902
.Lbb1900:
	callq bump
	movl $0, %eax
	jmp .Lbb1902
.Lbb1901:
	movl $2, %eax
.Lbb1902:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_41, @function
.size parse_41, .-parse_41
/* end function parse_41 */

.text
peak_41:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1912
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $1, %rax
	jz .Lbb1911
	cmpl $0, %edx
	jz .Lbb1910
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1910
.Lbb1907:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1909
	cmpl $0, %ebx
	jz .Lbb1910
	jmp .Lbb1907
.Lbb1909:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1913
.Lbb1910:
	movl $1, %eax
	jmp .Lbb1913
.Lbb1911:
	movl $0, %eax
	jmp .Lbb1913
.Lbb1912:
	movl $2, %eax
.Lbb1913:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_41, @function
.size peak_41, .-peak_41
/* end function peak_41 */

.data
.balign 8
expected_41_data:
	.quad 0
	.quad 1
/* end data */

.text
expected_41:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_41_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_41, @function
.size expected_41, .-expected_41
/* end function expected_41 */

.text
parse_42:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1917:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1929
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $19, %rsi
	jz .Lbb1928
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1922
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1917
.Lbb1922:
	cmpl $0, %r12d
	jz .Lbb1927
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1927
.Lbb1924:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1926
	cmpl $0, %ebx
	jz .Lbb1927
	jmp .Lbb1924
.Lbb1926:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1930
.Lbb1927:
	movl $1, %eax
	jmp .Lbb1930
.Lbb1928:
	callq bump
	movl $0, %eax
	jmp .Lbb1930
.Lbb1929:
	movl $2, %eax
.Lbb1930:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_42, @function
.size parse_42, .-parse_42
/* end function parse_42 */

.text
peak_42:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1940
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $19, %rax
	jz .Lbb1939
	cmpl $0, %edx
	jz .Lbb1938
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1938
.Lbb1935:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1937
	cmpl $0, %ebx
	jz .Lbb1938
	jmp .Lbb1935
.Lbb1937:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1941
.Lbb1938:
	movl $1, %eax
	jmp .Lbb1941
.Lbb1939:
	movl $0, %eax
	jmp .Lbb1941
.Lbb1940:
	movl $2, %eax
.Lbb1941:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_42, @function
.size peak_42, .-peak_42
/* end function peak_42 */

.data
.balign 8
expected_42_data:
	.quad 0
	.quad 19
/* end data */

.text
expected_42:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_42_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_42, @function
.size expected_42, .-expected_42
/* end function expected_42 */

.text
parse_43:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb1945:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1957
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $18, %rsi
	jz .Lbb1956
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb1950
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb1945
.Lbb1950:
	cmpl $0, %r12d
	jz .Lbb1955
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1955
.Lbb1952:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb1954
	cmpl $0, %ebx
	jz .Lbb1955
	jmp .Lbb1952
.Lbb1954:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1958
.Lbb1955:
	movl $1, %eax
	jmp .Lbb1958
.Lbb1956:
	callq bump
	movl $0, %eax
	jmp .Lbb1958
.Lbb1957:
	movl $2, %eax
.Lbb1958:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_43, @function
.size parse_43, .-parse_43
/* end function parse_43 */

.text
peak_43:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb1968
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $18, %rax
	jz .Lbb1967
	cmpl $0, %edx
	jz .Lbb1966
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb1966
.Lbb1963:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb1965
	cmpl $0, %ebx
	jz .Lbb1966
	jmp .Lbb1963
.Lbb1965:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb1969
.Lbb1966:
	movl $1, %eax
	jmp .Lbb1969
.Lbb1967:
	movl $0, %eax
	jmp .Lbb1969
.Lbb1968:
	movl $2, %eax
.Lbb1969:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_43, @function
.size peak_43, .-peak_43
/* end function peak_43 */

.data
.balign 8
expected_43_data:
	.quad 0
	.quad 18
/* end data */

.text
expected_43:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_43_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_43, @function
.size expected_43, .-expected_43
/* end function expected_43 */

.text
parse_44:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $40, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_43
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb1988
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb1976
	movl %r13d, %esi
	jmp .Lbb1980
.Lbb1976:
	cmpq $2, %rax
	jz .Lbb1979
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_43
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb1983
	movl %r13d, %esi
	jmp .Lbb1980
.Lbb1979:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_43
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb1980:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_40
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb1982
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb1980
.Lbb1982:
	movq %r12, %rax
.Lbb1983:
	cmpl $0, %eax
	jz .Lbb1987
	cmpq $2, %rax
	jz .Lbb1986
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb1987
.Lbb1986:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_40
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb1987:
	movl $0, %eax
	jmp .Lbb1989
.Lbb1988:
	movq %r12, %rax
.Lbb1989:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_44, @function
.size parse_44, .-parse_44
/* end function parse_44 */

.text
peak_44:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_43
	leave
	ret
.type peak_44, @function
.size peak_44, .-peak_44
/* end function peak_44 */

.data
.balign 8
expected_44_data:
	.quad 0
	.quad 18
/* end data */

.text
expected_44:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_44_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_44, @function
.size expected_44, .-expected_44
/* end function expected_44 */

.text
parse_45:
	pushq %rbp
	movq %rsp, %rbp
	callq parse_44
	movl $0, %eax
	leave
	ret
.type parse_45, @function
.size parse_45, .-parse_45
/* end function parse_45 */

.text
peak_45:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_44
	leave
	ret
.type peak_45, @function
.size peak_45, .-peak_45
/* end function peak_45 */

.text
expected_45:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, %rax
	movq $0, -24(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	leave
	ret
.type expected_45, @function
.size expected_45, .-expected_45
/* end function expected_45 */

.text
parse_46:
	pushq %rbp
	movq %rsp, %rbp
	subq $136, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	movq %r12, %rdi
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $5, %rbx
	movl %esi, %r14d
	movl $45, %esi
	movq %rdi, %r13
	callq push_long
	movl %r14d, %esi
	movq %r13, %rdi
	movl %esi, %r13d
	movl $42, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_41
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb2029
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb2004
	movl %r13d, %esi
	jmp .Lbb2010
.Lbb2004:
	cmpq $2, %rax
	jz .Lbb2008
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -120(%rbp), %rdi
	callq expected_41
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb2007
	movl %r13d, %esi
	jmp .Lbb2010
.Lbb2007:
	movq %rax, %r12
	jmp .Lbb2014
.Lbb2008:
	movq %rdi, %r12
	leaq -96(%rbp), %rdi
	callq expected_41
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movq %r12, %rdi
	movl %r13d, %esi
.Lbb2010:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_42
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb2013
	movl %esi, %r13d
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb2010
.Lbb2013:
	movl %esi, %r13d
.Lbb2014:
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb2016
	movl %r13d, %esi
	jmp .Lbb2020
.Lbb2016:
	cmpq $2, %rax
	jz .Lbb2019
	movq %rax, %r14
	movq %rbx, %rax
	subq $2, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_42
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb2024
	movl %r13d, %esi
	jmp .Lbb2020
.Lbb2019:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_42
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb2020:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_45
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb2023
	movq %rdi, %r12
	callq bump_err
	movq %r12, %rdi
	movl %r13d, %esi
	jmp .Lbb2020
.Lbb2023:
	movq %r12, %rax
.Lbb2024:
	cmpl $0, %eax
	jz .Lbb2028
	cmpq $2, %rax
	jz .Lbb2027
	movq %rbx, %rcx
	subq $2, %rcx
	cmpq %rcx, %rax
	jz .Lbb2028
.Lbb2027:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_45
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb2028:
	movl $0, %eax
	jmp .Lbb2030
.Lbb2029:
	movq %r12, %rax
.Lbb2030:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_46, @function
.size parse_46, .-parse_46
/* end function parse_46 */

.text
peak_46:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_41
	leave
	ret
.type peak_46, @function
.size peak_46, .-peak_46
/* end function peak_46 */

.data
.balign 8
expected_46_data:
	.quad 0
	.quad 1
/* end data */

.text
expected_46:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_46_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_46, @function
.size expected_46, .-expected_46
/* end function expected_46 */

.text
parse_47:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $12, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_46
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2037
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb2038
.Lbb2037:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb2038:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_47, @function
.size parse_47, .-parse_47
/* end function parse_47 */

.text
peak_47:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_46
	leave
	ret
.type peak_47, @function
.size peak_47, .-peak_47
/* end function peak_47 */

.data
.balign 8
expected_47_data:
	.quad 1
	.quad 12
/* end data */

.text
expected_47:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_47_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_47, @function
.size expected_47, .-expected_47
/* end function expected_47 */

.text
parse_48:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $17, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_59
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2047
	movq %rdi, %rbx
	callq parse_63
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2046
	callq exit_group
	movq %rbx, %rax
	jmp .Lbb2048
.Lbb2046:
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	movq %rdi, %r12
	callq pop
	movq %r12, %rdi
	movl $32, %esi
	callq last
	movq %rax, %r12
	movq 16(%rbx), %rax
	movq 8(%rbx), %r15
	imulq $32, %rax, %rdx
	movq %rdx, -24(%rbp)
	movq 16(%r12), %rcx
	movq 8(%r12), %rdi
	imulq $32, %rcx, %r14
	movq %rax, %r13
	addq %rcx, %r13
	imulq $2, %r13, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rbx
	imulq $64, %r13, %rdi
	callq malloc
	movq %r14, %rdx
	movq %rbx, %rdi
	movq %rax, %r14
	movq %r14, %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	movq %rdi, %rsi
	movq %rdi, %rbx
	movq %r14, %rdi
	callq memcpy
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rdx
	movq %r15, %rsi
	callq memcpy
	movq %rbx, %rdi
	movq -32(%rbp), %rbx
	callq free
	movq %r15, %rdi
	callq free
	movq %r14, 8(%r12)
	movq %r13, 16(%r12)
	movq %rbx, 24(%r12)
	movl $0, %eax
	jmp .Lbb2048
.Lbb2047:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb2048:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_48, @function
.size parse_48, .-parse_48
/* end function parse_48 */

.text
peak_48:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_59
	leave
	ret
.type peak_48, @function
.size peak_48, .-peak_48
/* end function peak_48 */

.data
.balign 8
expected_48_data:
	.quad 1
	.quad 15
/* end data */

.text
expected_48:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_48_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_48, @function
.size expected_48, .-expected_48
/* end function expected_48 */

.text
parse_49:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2054:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2066
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $8, %rsi
	jz .Lbb2065
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2059
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2054
.Lbb2059:
	cmpl $0, %r12d
	jz .Lbb2064
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2064
.Lbb2061:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2063
	cmpl $0, %ebx
	jz .Lbb2064
	jmp .Lbb2061
.Lbb2063:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2067
.Lbb2064:
	movl $1, %eax
	jmp .Lbb2067
.Lbb2065:
	callq bump
	movl $0, %eax
	jmp .Lbb2067
.Lbb2066:
	movl $2, %eax
.Lbb2067:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_49, @function
.size parse_49, .-parse_49
/* end function parse_49 */

.text
peak_49:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2077
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $8, %rax
	jz .Lbb2076
	cmpl $0, %edx
	jz .Lbb2075
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2075
.Lbb2072:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2074
	cmpl $0, %ebx
	jz .Lbb2075
	jmp .Lbb2072
.Lbb2074:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2078
.Lbb2075:
	movl $1, %eax
	jmp .Lbb2078
.Lbb2076:
	movl $0, %eax
	jmp .Lbb2078
.Lbb2077:
	movl $2, %eax
.Lbb2078:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_49, @function
.size peak_49, .-peak_49
/* end function peak_49 */

.data
.balign 8
expected_49_data:
	.quad 0
	.quad 8
/* end data */

.text
expected_49:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_49_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_49, @function
.size expected_49, .-expected_49
/* end function expected_49 */

.text
parse_50:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $48, %esi
	movq %rdi, %rbx
	callq push_delim
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	movl %esi, %r13d
	movl $49, %esi
	movq %rdi, %r12
	callq push_delim
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_48
	movl %r14d, %esi
	movq %r13, %rdi
	cmpl $0, %eax
	jnz .Lbb2098
.Lbb2082:
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_49
	movq %r13, %rdi
	cmpq $1, %rax
	jz .Lbb2097
	cmpl $0, %eax
	jnz .Lbb2085
	movl %r14d, %esi
	jmp .Lbb2089
.Lbb2085:
	cmpq $2, %rax
	jz .Lbb2096
	cmpq %rax, %rbx
	jnz .Lbb2096
	movq %rdi, %r13
	leaq -48(%rbp), %rdi
	callq expected_49
	movq %r13, %rdi
	movq %rax, %rsi
	movq %rdi, %r13
	callq missing
	movq %r13, %rdi
	movl %r14d, %esi
.Lbb2089:
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_48
	movq %r13, %rdi
	movq %rax, %r13
	cmpq $1, %r13
	jnz .Lbb2091
	movq %rdi, %r13
	callq bump_err
	movl %r14d, %esi
	movq %r13, %rdi
	jmp .Lbb2089
.Lbb2091:
	cmpl $0, %r13d
	jnz .Lbb2093
	movl %r14d, %esi
	jmp .Lbb2082
.Lbb2093:
	movq %rdi, %r15
	leaq -24(%rbp), %rdi
	callq expected_48
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	cmpq $2, %r13
	jz .Lbb2096
	cmpq %r13, %r12
	jnz .Lbb2096
	movl %r14d, %esi
	jmp .Lbb2082
.Lbb2096:
	callq pop_delim
	movl $0, %eax
	jmp .Lbb2100
.Lbb2097:
	movq %rdi, %r13
	callq bump_err
	movl %r14d, %esi
	movq %r13, %rdi
	jmp .Lbb2082
.Lbb2098:
	movq %rax, %rbx
	callq pop_delim
	movq %rbx, %rax
.Lbb2100:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_50, @function
.size parse_50, .-parse_50
/* end function parse_50 */

.text
peak_50:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_48
	leave
	ret
.type peak_50, @function
.size peak_50, .-peak_50
/* end function peak_50 */

.data
.balign 8
expected_50_data:
	.quad 1
	.quad 15
/* end data */

.text
expected_50:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_50_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_50, @function
.size expected_50, .-expected_50
/* end function expected_50 */

.text
parse_51:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2106:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2118
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $13, %rsi
	jz .Lbb2117
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2111
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2106
.Lbb2111:
	cmpl $0, %r12d
	jz .Lbb2116
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2116
.Lbb2113:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2115
	cmpl $0, %ebx
	jz .Lbb2116
	jmp .Lbb2113
.Lbb2115:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2119
.Lbb2116:
	movl $1, %eax
	jmp .Lbb2119
.Lbb2117:
	callq bump
	movl $0, %eax
	jmp .Lbb2119
.Lbb2118:
	movl $2, %eax
.Lbb2119:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_51, @function
.size parse_51, .-parse_51
/* end function parse_51 */

.text
peak_51:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2129
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $13, %rax
	jz .Lbb2128
	cmpl $0, %edx
	jz .Lbb2127
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2127
.Lbb2124:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2126
	cmpl $0, %ebx
	jz .Lbb2127
	jmp .Lbb2124
.Lbb2126:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2130
.Lbb2127:
	movl $1, %eax
	jmp .Lbb2130
.Lbb2128:
	movl $0, %eax
	jmp .Lbb2130
.Lbb2129:
	movl $2, %eax
.Lbb2130:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_51, @function
.size peak_51, .-peak_51
/* end function peak_51 */

.data
.balign 8
expected_51_data:
	.quad 0
	.quad 13
/* end data */

.text
expected_51:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_51_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_51, @function
.size expected_51, .-expected_51
/* end function expected_51 */

.text
parse_52:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2134:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2146
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $14, %rsi
	jz .Lbb2145
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2139
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2134
.Lbb2139:
	cmpl $0, %r12d
	jz .Lbb2144
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2144
.Lbb2141:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2143
	cmpl $0, %ebx
	jz .Lbb2144
	jmp .Lbb2141
.Lbb2143:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2147
.Lbb2144:
	movl $1, %eax
	jmp .Lbb2147
.Lbb2145:
	callq bump
	movl $0, %eax
	jmp .Lbb2147
.Lbb2146:
	movl $2, %eax
.Lbb2147:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_52, @function
.size parse_52, .-parse_52
/* end function parse_52 */

.text
peak_52:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2157
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $14, %rax
	jz .Lbb2156
	cmpl $0, %edx
	jz .Lbb2155
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2155
.Lbb2152:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2154
	cmpl $0, %ebx
	jz .Lbb2155
	jmp .Lbb2152
.Lbb2154:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2158
.Lbb2155:
	movl $1, %eax
	jmp .Lbb2158
.Lbb2156:
	movl $0, %eax
	jmp .Lbb2158
.Lbb2157:
	movl $2, %eax
.Lbb2158:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_52, @function
.size peak_52, .-peak_52
/* end function peak_52 */

.data
.balign 8
expected_52_data:
	.quad 0
	.quad 14
/* end data */

.text
expected_52:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_52_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_52, @function
.size expected_52, .-expected_52
/* end function expected_52 */

.text
parse_53:
	pushq %rbp
	movq %rsp, %rbp
	subq $48, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_51
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2177
	movl %esi, %r14d
	movl $52, %esi
	movq %rdi, %rbx
	callq push_delim
	movq %rbx, %rdi
	movq %rax, %rbx
	movl %r14d, %esi
.Lbb2164:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_50
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb2167
	movl %esi, %r13d
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb2164
.Lbb2167:
	movl %esi, %r14d
	cmpl $0, %r12d
	jnz .Lbb2170
	movl %r14d, %esi
	jmp .Lbb2171
.Lbb2170:
	movq %rdi, %r13
	leaq -48(%rbp), %rdi
	callq expected_50
	movq %r13, %rdi
	movq %rax, %rsi
	movq %rdi, %r13
	callq missing
	movl %r14d, %esi
	movq %r13, %rdi
	cmpq %r12, %rbx
	jnz .Lbb2175
.Lbb2171:
	movl %esi, %r13d
	movq %rdi, %rbx
	callq parse_52
	movq %rbx, %rdi
	cmpq $1, %rax
	jnz .Lbb2174
	movq %rdi, %rbx
	callq bump_err
	movq %rbx, %rdi
	movl %r13d, %esi
	jmp .Lbb2171
.Lbb2174:
	cmpl $0, %eax
	jz .Lbb2176
.Lbb2175:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_52
	movq %rbx, %rdi
	movq %rax, %rsi
	movq %rdi, %rbx
	callq missing
	movq %rbx, %rdi
.Lbb2176:
	callq pop_delim
	movl $0, %eax
.Lbb2177:
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_53, @function
.size parse_53, .-parse_53
/* end function parse_53 */

.text
peak_53:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_51
	leave
	ret
.type peak_53, @function
.size peak_53, .-peak_53
/* end function peak_53 */

.data
.balign 8
expected_53_data:
	.quad 0
	.quad 13
/* end data */

.text
expected_53:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_53_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_53, @function
.size expected_53, .-expected_53
/* end function expected_53 */

.text
parse_54:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $14, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_53
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2184
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb2185
.Lbb2184:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb2185:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_54, @function
.size parse_54, .-parse_54
/* end function parse_54 */

.text
peak_54:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_53
	leave
	ret
.type peak_54, @function
.size peak_54, .-peak_54
/* end function peak_54 */

.data
.balign 8
expected_54_data:
	.quad 1
	.quad 14
/* end data */

.text
expected_54:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_54_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_54, @function
.size expected_54, .-expected_54
/* end function expected_54 */

.text
parse_55:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2191:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2203
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $7, %rsi
	jz .Lbb2202
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2196
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2191
.Lbb2196:
	cmpl $0, %r12d
	jz .Lbb2201
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2201
.Lbb2198:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2200
	cmpl $0, %ebx
	jz .Lbb2201
	jmp .Lbb2198
.Lbb2200:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2204
.Lbb2201:
	movl $1, %eax
	jmp .Lbb2204
.Lbb2202:
	callq bump
	movl $0, %eax
	jmp .Lbb2204
.Lbb2203:
	movl $2, %eax
.Lbb2204:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_55, @function
.size parse_55, .-parse_55
/* end function parse_55 */

.text
peak_55:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2214
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $7, %rax
	jz .Lbb2213
	cmpl $0, %edx
	jz .Lbb2212
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2212
.Lbb2209:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2211
	cmpl $0, %ebx
	jz .Lbb2212
	jmp .Lbb2209
.Lbb2211:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2215
.Lbb2212:
	movl $1, %eax
	jmp .Lbb2215
.Lbb2213:
	movl $0, %eax
	jmp .Lbb2215
.Lbb2214:
	movl $2, %eax
.Lbb2215:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_55, @function
.size peak_55, .-peak_55
/* end function peak_55 */

.data
.balign 8
expected_55_data:
	.quad 0
	.quad 7
/* end data */

.text
expected_55:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_55_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_55, @function
.size expected_55, .-expected_55
/* end function expected_55 */

.text
parse_56:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $54, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_55
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb2234
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb2222
	movl %r13d, %esi
	jmp .Lbb2226
.Lbb2222:
	cmpq $2, %rax
	jz .Lbb2225
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_55
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb2229
	movl %r13d, %esi
	jmp .Lbb2226
.Lbb2225:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_55
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb2226:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_54
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb2228
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb2226
.Lbb2228:
	movq %r12, %rax
.Lbb2229:
	cmpl $0, %eax
	jz .Lbb2233
	cmpq $2, %rax
	jz .Lbb2232
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb2233
.Lbb2232:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_54
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb2233:
	movl $0, %eax
	jmp .Lbb2235
.Lbb2234:
	movq %r12, %rax
.Lbb2235:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_56, @function
.size parse_56, .-parse_56
/* end function parse_56 */

.text
peak_56:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_55
	leave
	ret
.type peak_56, @function
.size peak_56, .-peak_56
/* end function peak_56 */

.data
.balign 8
expected_56_data:
	.quad 0
	.quad 7
/* end data */

.text
expected_56:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_56_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_56, @function
.size expected_56, .-expected_56
/* end function expected_56 */

.text
parse_57:
	pushq %rbp
	movq %rsp, %rbp
	callq parse_56
	movl $0, %eax
	leave
	ret
.type parse_57, @function
.size parse_57, .-parse_57
/* end function parse_57 */

.text
peak_57:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_56
	leave
	ret
.type peak_57, @function
.size peak_57, .-peak_57
/* end function peak_57 */

.text
expected_57:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	movq %rdi, %rax
	movq $0, -24(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	leave
	ret
.type expected_57, @function
.size expected_57, .-expected_57
/* end function expected_57 */

.text
parse_58:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $57, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_2
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb2262
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb2250
	movl %r13d, %esi
	jmp .Lbb2254
.Lbb2250:
	cmpq $2, %rax
	jz .Lbb2253
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_2
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb2257
	movl %r13d, %esi
	jmp .Lbb2254
.Lbb2253:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_2
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb2254:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_57
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb2256
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb2254
.Lbb2256:
	movq %r12, %rax
.Lbb2257:
	cmpl $0, %eax
	jz .Lbb2261
	cmpq $2, %rax
	jz .Lbb2260
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb2261
.Lbb2260:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_57
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb2261:
	movl $0, %eax
	jmp .Lbb2263
.Lbb2262:
	movq %r12, %rax
.Lbb2263:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_58, @function
.size parse_58, .-parse_58
/* end function parse_58 */

.text
peak_58:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_2
	leave
	ret
.type peak_58, @function
.size peak_58, .-peak_58
/* end function peak_58 */

.data
.balign 8
expected_58_data:
	.quad 1
	.quad 1
/* end data */

.text
expected_58:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_58_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_58, @function
.size expected_58, .-expected_58
/* end function expected_58 */

.text
parse_59:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $15, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_58
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2270
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb2271
.Lbb2270:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb2271:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_59, @function
.size parse_59, .-parse_59
/* end function parse_59 */

.text
peak_59:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_58
	leave
	ret
.type peak_59, @function
.size peak_59, .-peak_59
/* end function peak_59 */

.data
.balign 8
expected_59_data:
	.quad 1
	.quad 15
/* end data */

.text
expected_59:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_59_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_59, @function
.size expected_59, .-expected_59
/* end function expected_59 */

.text
parse_60:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2277:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2289
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $22, %rsi
	jz .Lbb2288
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2282
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2277
.Lbb2282:
	cmpl $0, %r12d
	jz .Lbb2287
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2287
.Lbb2284:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2286
	cmpl $0, %ebx
	jz .Lbb2287
	jmp .Lbb2284
.Lbb2286:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2290
.Lbb2287:
	movl $1, %eax
	jmp .Lbb2290
.Lbb2288:
	callq bump
	movl $0, %eax
	jmp .Lbb2290
.Lbb2289:
	movl $2, %eax
.Lbb2290:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_60, @function
.size parse_60, .-parse_60
/* end function parse_60 */

.text
peak_60:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2300
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $22, %rax
	jz .Lbb2299
	cmpl $0, %edx
	jz .Lbb2298
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2298
.Lbb2295:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2297
	cmpl $0, %ebx
	jz .Lbb2298
	jmp .Lbb2295
.Lbb2297:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2301
.Lbb2298:
	movl $1, %eax
	jmp .Lbb2301
.Lbb2299:
	movl $0, %eax
	jmp .Lbb2301
.Lbb2300:
	movl $2, %eax
.Lbb2301:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_60, @function
.size peak_60, .-peak_60
/* end function peak_60 */

.data
.balign 8
expected_60_data:
	.quad 0
	.quad 22
/* end data */

.text
expected_60:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_60_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_60, @function
.size expected_60, .-expected_60
/* end function expected_60 */

.text
parse_61:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2305:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2317
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $21, %rsi
	jz .Lbb2316
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2310
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2305
.Lbb2310:
	cmpl $0, %r12d
	jz .Lbb2315
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2315
.Lbb2312:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2314
	cmpl $0, %ebx
	jz .Lbb2315
	jmp .Lbb2312
.Lbb2314:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2318
.Lbb2315:
	movl $1, %eax
	jmp .Lbb2318
.Lbb2316:
	callq bump
	movl $0, %eax
	jmp .Lbb2318
.Lbb2317:
	movl $2, %eax
.Lbb2318:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_61, @function
.size parse_61, .-parse_61
/* end function parse_61 */

.text
peak_61:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2328
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $21, %rax
	jz .Lbb2327
	cmpl $0, %edx
	jz .Lbb2326
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2326
.Lbb2323:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2325
	cmpl $0, %ebx
	jz .Lbb2326
	jmp .Lbb2323
.Lbb2325:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2329
.Lbb2326:
	movl $1, %eax
	jmp .Lbb2329
.Lbb2327:
	movl $0, %eax
	jmp .Lbb2329
.Lbb2328:
	movl $2, %eax
.Lbb2329:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_61, @function
.size peak_61, .-peak_61
/* end function peak_61 */

.data
.balign 8
expected_61_data:
	.quad 0
	.quad 21
/* end data */

.text
expected_61:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_61_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_61, @function
.size expected_61, .-expected_61
/* end function expected_61 */

.text
parse_62:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $61, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_60
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb2348
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb2336
	movl %r13d, %esi
	jmp .Lbb2340
.Lbb2336:
	cmpq $2, %rax
	jz .Lbb2339
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_60
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb2343
	movl %r13d, %esi
	jmp .Lbb2340
.Lbb2339:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_60
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb2340:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_61
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb2342
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb2340
.Lbb2342:
	movq %r12, %rax
.Lbb2343:
	cmpl $0, %eax
	jz .Lbb2347
	cmpq $2, %rax
	jz .Lbb2346
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb2347
.Lbb2346:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_61
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb2347:
	movl $0, %eax
	jmp .Lbb2349
.Lbb2348:
	movq %r12, %rax
.Lbb2349:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_62, @function
.size parse_62, .-parse_62
/* end function parse_62 */

.text
peak_62:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_60
	leave
	ret
.type peak_62, @function
.size peak_62, .-peak_62
/* end function peak_62 */

.data
.balign 8
expected_62_data:
	.quad 0
	.quad 22
/* end data */

.text
expected_62:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_62_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_62, @function
.size expected_62, .-expected_62
/* end function expected_62 */

.text
parse_63:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $16, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_62
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2356
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb2357
.Lbb2356:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb2357:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_63, @function
.size parse_63, .-parse_63
/* end function parse_63 */

.text
peak_63:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_62
	leave
	ret
.type peak_63, @function
.size peak_63, .-peak_63
/* end function peak_63 */

.data
.balign 8
expected_63_data:
	.quad 1
	.quad 16
/* end data */

.text
expected_63:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_63_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_63, @function
.size expected_63, .-expected_63
/* end function expected_63 */

.text
parse_64:
	pushq %rbp
	movq %rsp, %rbp
	subq $40, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $17, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_59
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2366
	movq %rdi, %rbx
	callq parse_63
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2365
	callq exit_group
	movq %rbx, %rax
	jmp .Lbb2367
.Lbb2365:
	addq $24, %rdi
	movl $32, %esi
	movq %rdi, %rbx
	callq last
	movq %rbx, %rdi
	movq %rax, %rbx
	movl $32, %esi
	movq %rdi, %r12
	callq pop
	movq %r12, %rdi
	movl $32, %esi
	callq last
	movq %rax, %r12
	movq 16(%rbx), %rax
	movq 8(%rbx), %r15
	imulq $32, %rax, %rdx
	movq %rdx, -24(%rbp)
	movq 16(%r12), %rcx
	movq 8(%r12), %rdi
	imulq $32, %rcx, %r14
	movq %rax, %r13
	addq %rcx, %r13
	imulq $2, %r13, %rbx
	movq %rbx, -32(%rbp)
	movq %rdi, %rbx
	imulq $64, %r13, %rdi
	callq malloc
	movq %r14, %rdx
	movq %rbx, %rdi
	movq %rax, %r14
	movq %r14, %rax
	addq %rdx, %rax
	movq %rax, -16(%rbp)
	movq %rdi, %rsi
	movq %rdi, %rbx
	movq %r14, %rdi
	callq memcpy
	movq %rbx, %rdi
	movq %rdi, %rbx
	movq -16(%rbp), %rdi
	movq -24(%rbp), %rdx
	movq %r15, %rsi
	callq memcpy
	movq %rbx, %rdi
	movq -32(%rbp), %rbx
	callq free
	movq %r15, %rdi
	callq free
	movq %r14, 8(%r12)
	movq %r13, 16(%r12)
	movq %rbx, 24(%r12)
	movl $0, %eax
	jmp .Lbb2367
.Lbb2366:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb2367:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_64, @function
.size parse_64, .-parse_64
/* end function parse_64 */

.text
peak_64:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_59
	leave
	ret
.type peak_64, @function
.size peak_64, .-peak_64
/* end function peak_64 */

.data
.balign 8
expected_64_data:
	.quad 1
	.quad 15
/* end data */

.text
expected_64:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_64_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_64, @function
.size expected_64, .-expected_64
/* end function expected_64 */

.text
parse_65:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2373:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2385
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $3, %rsi
	jz .Lbb2384
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2378
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2373
.Lbb2378:
	cmpl $0, %r12d
	jz .Lbb2383
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2383
.Lbb2380:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2382
	cmpl $0, %ebx
	jz .Lbb2383
	jmp .Lbb2380
.Lbb2382:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2386
.Lbb2383:
	movl $1, %eax
	jmp .Lbb2386
.Lbb2384:
	callq bump
	movl $0, %eax
	jmp .Lbb2386
.Lbb2385:
	movl $2, %eax
.Lbb2386:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_65, @function
.size parse_65, .-parse_65
/* end function parse_65 */

.text
peak_65:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2396
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $3, %rax
	jz .Lbb2395
	cmpl $0, %edx
	jz .Lbb2394
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2394
.Lbb2391:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2393
	cmpl $0, %ebx
	jz .Lbb2394
	jmp .Lbb2391
.Lbb2393:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2397
.Lbb2394:
	movl $1, %eax
	jmp .Lbb2397
.Lbb2395:
	movl $0, %eax
	jmp .Lbb2397
.Lbb2396:
	movl $2, %eax
.Lbb2397:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_65, @function
.size peak_65, .-peak_65
/* end function peak_65 */

.data
.balign 8
expected_65_data:
	.quad 0
	.quad 3
/* end data */

.text
expected_65:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_65_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_65, @function
.size expected_65, .-expected_65
/* end function expected_65 */

.text
parse_66:
	pushq %rbp
	movq %rsp, %rbp
	subq $88, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movq %rdi, %r12
	addq $56, %rdi
	movq 64(%r12), %rax
	movq %rax, %rbx
	addq $4, %rbx
	movl %esi, %r13d
	movl $48, %esi
	callq push_long
	movl %r13d, %esi
	movq %r12, %rdi
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_65
	movq %r12, %rdi
	movq %rax, %r12
	cmpl $0, %r12d
	jnz .Lbb2416
	movq %rdi, %r14
	callq pop_delim
	movq %r14, %rdi
	movq %r12, %rax
	cmpl $0, %eax
	jnz .Lbb2404
	movl %r13d, %esi
	jmp .Lbb2408
.Lbb2404:
	cmpq $2, %rax
	jz .Lbb2407
	movq %rax, %r14
	movq %rbx, %rax
	subq $1, %rax
	cmpq %rax, %r14
	setz %r12b
	movzbq %r12b, %r12
	movq %rdi, %r15
	leaq -72(%rbp), %rdi
	callq expected_65
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	movq %r14, %rax
	cmpl $0, %r12d
	jz .Lbb2411
	movl %r13d, %esi
	jmp .Lbb2408
.Lbb2407:
	movq %rdi, %r12
	leaq -48(%rbp), %rdi
	callq expected_65
	movq %r12, %rdi
	movq %rax, %rsi
	movq %rdi, %r12
	callq missing
	movl %r13d, %esi
	movq %r12, %rdi
.Lbb2408:
	movl %esi, %r13d
	movq %rdi, %r12
	callq parse_48
	movq %r12, %rdi
	movq %rax, %r12
	cmpq $1, %r12
	jnz .Lbb2410
	movq %rdi, %r12
	callq bump_err
	movl %r13d, %esi
	movq %r12, %rdi
	jmp .Lbb2408
.Lbb2410:
	movq %r12, %rax
.Lbb2411:
	cmpl $0, %eax
	jz .Lbb2415
	cmpq $2, %rax
	jz .Lbb2414
	movq %rbx, %rcx
	subq $1, %rcx
	cmpq %rcx, %rax
	jz .Lbb2415
.Lbb2414:
	movq %rdi, %rbx
	leaq -24(%rbp), %rdi
	callq expected_48
	movq %rbx, %rdi
	movq %rax, %rsi
	callq missing
.Lbb2415:
	movl $0, %eax
	jmp .Lbb2417
.Lbb2416:
	movq %r12, %rax
.Lbb2417:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_66, @function
.size parse_66, .-parse_66
/* end function parse_66 */

.text
peak_66:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_65
	leave
	ret
.type peak_66, @function
.size peak_66, .-peak_66
/* end function peak_66 */

.data
.balign 8
expected_66_data:
	.quad 0
	.quad 3
/* end data */

.text
expected_66:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_66_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_66, @function
.size expected_66, .-expected_66
/* end function expected_66 */

.text
parse_67:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movl $18, %esi
	movq %rdi, %rbx
	callq enter_group
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rdi, %rbx
	callq parse_66
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %ebx
	jnz .Lbb2424
	callq exit_group
	movq %rbx, %rax
	movq %rax, %rbx
	jmp .Lbb2425
.Lbb2424:
	addq $24, %rdi
	movl $32, %esi
	callq pop
	movq %rbx, %rax
.Lbb2425:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_67, @function
.size parse_67, .-parse_67
/* end function parse_67 */

.text
peak_67:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_66
	leave
	ret
.type peak_67, @function
.size peak_67, .-peak_67
/* end function peak_67 */

.data
.balign 8
expected_67_data:
	.quad 1
	.quad 18
/* end data */

.text
expected_67:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_67_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_67, @function
.size expected_67, .-expected_67
/* end function expected_67 */

.text
parse_68:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_31
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2434
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_37
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2434
	movl %esi, %r12d
	movq %rdi, %rbx
	callq parse_47
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2434
	callq parse_67
.Lbb2434:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_68, @function
.size parse_68, .-parse_68
/* end function parse_68 */

.text
peak_68:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r13d
	movq %rsi, %r12
	movq %rdi, %rbx
	callq peak_31
	movl %r13d, %edx
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2439
	movl %edx, %r13d
	movq %rsi, %r12
	movq %rdi, %rbx
	callq peak_37
	movl %r13d, %edx
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2439
	movl %edx, %r13d
	movq %rsi, %r12
	movq %rdi, %rbx
	callq peak_47
	movl %r13d, %edx
	movq %r12, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2439
	callq peak_67
.Lbb2439:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_68, @function
.size peak_68, .-peak_68
/* end function peak_68 */

.data
.balign 8
expected_68_data:
	.quad 1
	.quad 9
	.quad 1
	.quad 10
	.quad 1
	.quad 12
	.quad 1
	.quad 18
/* end data */

.text
expected_68:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $64, %edi
	callq malloc
	movq %rax, %rbx
	movl $64, %edx
	leaq expected_68_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $4, -16(%rbp)
	movq $4, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_68, @function
.size expected_68, .-expected_68
/* end function expected_68 */

.text
parse_69:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2443:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2455
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $20, %rsi
	jz .Lbb2454
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2448
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2443
.Lbb2448:
	cmpl $0, %r12d
	jz .Lbb2453
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2453
.Lbb2450:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2452
	cmpl $0, %ebx
	jz .Lbb2453
	jmp .Lbb2450
.Lbb2452:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2456
.Lbb2453:
	movl $1, %eax
	jmp .Lbb2456
.Lbb2454:
	callq bump
	movl $0, %eax
	jmp .Lbb2456
.Lbb2455:
	movl $2, %eax
.Lbb2456:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_69, @function
.size parse_69, .-parse_69
/* end function parse_69 */

.text
peak_69:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2466
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $20, %rax
	jz .Lbb2465
	cmpl $0, %edx
	jz .Lbb2464
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2464
.Lbb2461:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2463
	cmpl $0, %ebx
	jz .Lbb2464
	jmp .Lbb2461
.Lbb2463:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2467
.Lbb2464:
	movl $1, %eax
	jmp .Lbb2467
.Lbb2465:
	movl $0, %eax
	jmp .Lbb2467
.Lbb2466:
	movl $2, %eax
.Lbb2467:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_69, @function
.size peak_69, .-peak_69
/* end function peak_69 */

.data
.balign 8
expected_69_data:
	.quad 0
	.quad 20
/* end data */

.text
expected_69:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_69_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_69, @function
.size expected_69, .-expected_69
/* end function expected_69 */

.text
parse_70:
	pushq %rbp
	movq %rsp, %rbp
	subq $56, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	pushq %r14
	pushq %r15
	movl %esi, %r12d
	movl $68, %esi
	movq %rdi, %rbx
	callq push_delim
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %rbx
	movl %esi, %r13d
	movl $69, %esi
	movq %rdi, %r12
	callq push_delim
	movl %r13d, %esi
	movq %r12, %rdi
	movq %rax, %r12
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_68
	movl %r14d, %esi
	movq %r13, %rdi
	cmpl $0, %eax
	jnz .Lbb2487
.Lbb2471:
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_69
	movq %r13, %rdi
	cmpq $1, %rax
	jz .Lbb2486
	cmpl $0, %eax
	jnz .Lbb2474
	movl %r14d, %esi
	jmp .Lbb2478
.Lbb2474:
	cmpq $2, %rax
	jz .Lbb2485
	cmpq %rax, %rbx
	jnz .Lbb2485
	movq %rdi, %r13
	leaq -48(%rbp), %rdi
	callq expected_69
	movq %r13, %rdi
	movq %rax, %rsi
	movq %rdi, %r13
	callq missing
	movq %r13, %rdi
	movl %r14d, %esi
.Lbb2478:
	movl %esi, %r14d
	movq %rdi, %r13
	callq parse_68
	movq %r13, %rdi
	movq %rax, %r13
	cmpq $1, %r13
	jnz .Lbb2480
	movq %rdi, %r13
	callq bump_err
	movl %r14d, %esi
	movq %r13, %rdi
	jmp .Lbb2478
.Lbb2480:
	cmpl $0, %r13d
	jnz .Lbb2482
	movl %r14d, %esi
	jmp .Lbb2471
.Lbb2482:
	movq %rdi, %r15
	leaq -24(%rbp), %rdi
	callq expected_68
	movq %r15, %rdi
	movq %rax, %rsi
	movq %rdi, %r15
	callq missing
	movq %r15, %rdi
	cmpq $2, %r13
	jz .Lbb2485
	cmpq %r13, %r12
	jnz .Lbb2485
	movl %r14d, %esi
	jmp .Lbb2471
.Lbb2485:
	callq pop_delim
	movl $0, %eax
	jmp .Lbb2489
.Lbb2486:
	movq %rdi, %r13
	callq bump_err
	movl %r14d, %esi
	movq %r13, %rdi
	jmp .Lbb2471
.Lbb2487:
	movq %rax, %rbx
	callq pop_delim
	movq %rbx, %rax
.Lbb2489:
	popq %r15
	popq %r14
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_70, @function
.size parse_70, .-parse_70
/* end function parse_70 */

.text
peak_70:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_68
	leave
	ret
.type peak_70, @function
.size peak_70, .-peak_70
/* end function peak_70 */

.data
.balign 8
expected_70_data:
	.quad 1
	.quad 9
	.quad 1
	.quad 10
	.quad 1
	.quad 12
	.quad 1
	.quad 18
/* end data */

.text
expected_70:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $64, %edi
	callq malloc
	movq %rax, %rbx
	movl $64, %edx
	leaq expected_70_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $4, -16(%rbp)
	movq $4, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_70, @function
.size expected_70, .-expected_70
/* end function expected_70 */

.text
parse_71:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %esi, %r12d
.Lbb2495:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2507
	movq %rdi, %rbx
	callq current_kind
	movq %rbx, %rdi
	movq %rax, %rsi
	cmpq $5, %rsi
	jz .Lbb2506
	movq %rdi, %rbx
	addq $80, %rdi
	callq contains_long
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2500
	movq %rdi, %rbx
	callq bump
	movl %r12d, %esi
	movq %rbx, %rdi
	movl %esi, %r12d
	jmp .Lbb2495
.Lbb2500:
	cmpl $0, %r12d
	jz .Lbb2505
	movq %rdi, %r12
	addq $56, %r12
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2505
.Lbb2502:
	subq $1, %rbx
	movq %rbx, %rdx
	movl $8, %esi
	movq %rdi, %r13
	movq %r12, %rdi
	callq get
	movq %r13, %rdi
	movq (%rax), %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r13
	callq peak_by_id
	movq %r13, %rdi
	cmpl $0, %eax
	jz .Lbb2504
	cmpl $0, %ebx
	jz .Lbb2505
	jmp .Lbb2502
.Lbb2504:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2508
.Lbb2505:
	movl $1, %eax
	jmp .Lbb2508
.Lbb2506:
	callq bump
	movl $0, %eax
	jmp .Lbb2508
.Lbb2507:
	movl $2, %eax
.Lbb2508:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type parse_71, @function
.size parse_71, .-parse_71
/* end function parse_71 */

.text
peak_71:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
	pushq %r12
	pushq %r13
	movl %edx, %r12d
	movq %rsi, %r13
	movq %rdi, %rbx
	callq is_eof
	movq %r13, %rsi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2518
	movq %rdi, %rbx
	callq kind_at_offset
	movl %r12d, %edx
	movq %rbx, %rdi
	cmpq $5, %rax
	jz .Lbb2517
	cmpl $0, %edx
	jz .Lbb2516
	movq 64(%rdi), %rbx
	cmpl $0, %ebx
	jz .Lbb2516
.Lbb2513:
	subq $1, %rbx
	movq %rbx, %rcx
	movl $0, %edx
	movl $0, %esi
	movq %rdi, %r12
	callq peak_by_id
	movq %r12, %rdi
	cmpl $0, %eax
	jz .Lbb2515
	cmpl $0, %ebx
	jz .Lbb2516
	jmp .Lbb2513
.Lbb2515:
	movq %rbx, %rax
	addq $3, %rax
	jmp .Lbb2519
.Lbb2516:
	movl $1, %eax
	jmp .Lbb2519
.Lbb2517:
	movl $0, %eax
	jmp .Lbb2519
.Lbb2518:
	movl $2, %eax
.Lbb2519:
	popq %r13
	popq %r12
	popq %rbx
	leave
	ret
.type peak_71, @function
.size peak_71, .-peak_71
/* end function peak_71 */

.data
.balign 8
expected_71_data:
	.quad 0
	.quad 5
/* end data */

.text
expected_71:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $16, %edi
	callq malloc
	movq %rax, %rbx
	movl $16, %edx
	leaq expected_71_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $1, -16(%rbp)
	movq $1, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_71, @function
.size expected_71, .-expected_71
/* end function expected_71 */

.text
parse_72:
	pushq %rbp
	movq %rsp, %rbp
	pushq %rbx
	pushq %r12
	movl %esi, %r12d
	movq %rdi, %rbx
	callq after_skipped
	movq %rbx, %rdi
	movq %rax, %rsi
	movl $1, %edx
	movq %rdi, %rbx
	callq peak_70
	movl %r12d, %esi
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2526
	movl %esi, %r12d
	movl $5, %esi
	movq %rdi, %rbx
	callq skip
	movl %r12d, %esi
	movq %rbx, %rdi
	movq %rax, %r12
	movq %rdi, %rbx
	callq parse_70
	movq %rbx, %rdi
	movq %rax, %rbx
	cmpl $0, %r12d
	jnz .Lbb2525
	movq %rbx, %rax
	jmp .Lbb2526
.Lbb2525:
	movl $5, %esi
	callq unskip
	movq %rbx, %rax
.Lbb2526:
	popq %r12
	popq %rbx
	leave
	ret
.type parse_72, @function
.size parse_72, .-parse_72
/* end function parse_72 */

.text
peak_72:
	pushq %rbp
	movq %rsp, %rbp
	callq peak_70
	leave
	ret
.type peak_72, @function
.size peak_72, .-peak_72
/* end function peak_72 */

.data
.balign 8
expected_72_data:
	.quad 1
	.quad 9
	.quad 1
	.quad 10
	.quad 1
	.quad 12
	.quad 1
	.quad 18
/* end data */

.text
expected_72:
	pushq %rbp
	movq %rsp, %rbp
	subq $32, %rsp
	pushq %rbx
	pushq %r12
	movq %rdi, %r12
	movl $64, %edi
	callq malloc
	movq %rax, %rbx
	movl $64, %edx
	leaq expected_72_data(%rip), %rsi
	movq %rbx, %rdi
	callq memcpy
	movq %r12, %rax
	movq %rbx, -24(%rbp)
	movq $4, -16(%rbp)
	movq $4, -8(%rbp)
	movq -24(%rbp), %rcx
	movq %rcx, 0(%rax)
	movq -16(%rbp), %rcx
	movq %rcx, 8(%rax)
	movq -8(%rbp), %rcx
	movq %rcx, 16(%rax)
	popq %r12
	popq %rbx
	leave
	ret
.type expected_72, @function
.size expected_72, .-expected_72
/* end function expected_72 */

.data
.balign 8
root_group_id:
	.int 21
/* end data */

.text
.globl parse
parse:
	pushq %rbp
	movq %rsp, %rbp
	subq $8, %rsp
	pushq %rbx
.Lbb2532:
	movl $1, %esi
	movq %rdi, %rbx
	callq parse_72
	movq %rbx, %rdi
	cmpl $0, %eax
	jz .Lbb2535
	cmpq $2, %rax
	jz .Lbb2535
	movq %rdi, %rbx
	callq bump_err
	movq %rbx, %rdi
	jmp .Lbb2532
.Lbb2535:
	movq %rdi, %rbx
	callq is_eof
	movq %rbx, %rdi
	cmpl $0, %eax
	jnz .Lbb2537
	movq %rdi, %rbx
	callq bump_err
	movq %rbx, %rdi
	jmp .Lbb2535
.Lbb2537:
	movl $1, %eax
	popq %rbx
	leave
	ret
.type parse, @function
.size parse, .-parse
/* end function parse */

.data
.balign 8
_expr_group_name:
	.ascii "_expr"
	.byte 0
/* end data */

.data
.balign 8
_expr_group_name_len:
	.quad 5
/* end data */

.data
.balign 8
named_group_name:
	.ascii "named"
	.byte 0
/* end data */

.data
.balign 8
named_group_name_len:
	.quad 5
/* end data */

.data
.balign 8
_atom_group_name:
	.ascii "_atom"
	.byte 0
/* end data */

.data
.balign 8
_atom_group_name_len:
	.quad 5
/* end data */

.data
.balign 8
call_name_group_name:
	.ascii "call_name"
	.byte 0
/* end data */

.data
.balign 8
call_name_group_name_len:
	.quad 9
/* end data */

.data
.balign 8
args_group_name:
	.ascii "args"
	.byte 0
/* end data */

.data
.balign 8
args_group_name_len:
	.quad 4
/* end data */

.data
.balign 8
call_group_name:
	.ascii "call"
	.byte 0
/* end data */

.data
.balign 8
call_group_name_len:
	.quad 4
/* end data */

.data
.balign 8
member_call_group_name:
	.ascii "member_call"
	.byte 0
/* end data */

.data
.balign 8
member_call_group_name_len:
	.quad 11
/* end data */

.data
.balign 8
seq_group_name:
	.ascii "seq"
	.byte 0
/* end data */

.data
.balign 8
seq_group_name_len:
	.quad 3
/* end data */

.data
.balign 8
choice_group_name:
	.ascii "choice"
	.byte 0
/* end data */

.data
.balign 8
choice_group_name_len:
	.quad 6
/* end data */

.data
.balign 8
kw_def_group_name:
	.ascii "kw_def"
	.byte 0
/* end data */

.data
.balign 8
kw_def_group_name_len:
	.quad 6
/* end data */

.data
.balign 8
token_def_group_name:
	.ascii "token_def"
	.byte 0
/* end data */

.data
.balign 8
token_def_group_name_len:
	.quad 9
/* end data */

.data
.balign 8
fold_stmt_group_name:
	.ascii "fold_stmt"
	.byte 0
/* end data */

.data
.balign 8
fold_stmt_group_name_len:
	.quad 9
/* end data */

.data
.balign 8
parser_def_group_name:
	.ascii "parser_def"
	.byte 0
/* end data */

.data
.balign 8
parser_def_group_name_len:
	.quad 10
/* end data */

.data
.balign 8
_query_group_name:
	.ascii "_query"
	.byte 0
/* end data */

.data
.balign 8
_query_group_name_len:
	.quad 6
/* end data */

.data
.balign 8
child_query_group_name:
	.ascii "child_query"
	.byte 0
/* end data */

.data
.balign 8
child_query_group_name_len:
	.quad 11
/* end data */

.data
.balign 8
group_query_group_name:
	.ascii "group_query"
	.byte 0
/* end data */

.data
.balign 8
group_query_group_name_len:
	.quad 11
/* end data */

.data
.balign 8
label_group_name:
	.ascii "label"
	.byte 0
/* end data */

.data
.balign 8
label_group_name_len:
	.quad 5
/* end data */

.data
.balign 8
labelled_query_group_name:
	.ascii "labelled_query"
	.byte 0
/* end data */

.data
.balign 8
labelled_query_group_name_len:
	.quad 14
/* end data */

.data
.balign 8
highlight_def_group_name:
	.ascii "highlight_def"
	.byte 0
/* end data */

.data
.balign 8
highlight_def_group_name_len:
	.quad 13
/* end data */

.data
.balign 8
_stmt_group_name:
	.ascii "_stmt"
	.byte 0
/* end data */

.data
.balign 8
_stmt_group_name_len:
	.quad 5
/* end data */

.data
.balign 8
_root_group_name:
	.ascii "_root"
	.byte 0
/* end data */

.data
.balign 8
_root_group_name_len:
	.quad 5
/* end data */

.data
.balign 8
root_group_name:
	.ascii "root"
	.byte 0
/* end data */

.data
.balign 8
root_group_name_len:
	.quad 4
/* end data */

.data
.balign 8
err_group_name:
	.ascii "group_error"
	.byte 0
/* end data */

.text
.globl group_name
group_name:
	pushq %rbp
	movq %rsp, %rbp
	cmpl $0, %edi
	leaq _expr_group_name(%rip), %rax
	jz .Lbb2584
	cmpl $1, %edi
	leaq named_group_name(%rip), %rax
	jz .Lbb2583
	cmpl $2, %edi
	leaq _atom_group_name(%rip), %rax
	jz .Lbb2582
	cmpl $3, %edi
	leaq call_name_group_name(%rip), %rax
	jz .Lbb2581
	cmpl $4, %edi
	leaq args_group_name(%rip), %rax
	jz .Lbb2580
	cmpl $5, %edi
	leaq call_group_name(%rip), %rax
	jz .Lbb2579
	cmpl $6, %edi
	leaq member_call_group_name(%rip), %rax
	jz .Lbb2578
	cmpl $7, %edi
	leaq seq_group_name(%rip), %rax
	jz .Lbb2577
	cmpl $8, %edi
	leaq choice_group_name(%rip), %rax
	jz .Lbb2576
	cmpl $9, %edi
	leaq kw_def_group_name(%rip), %rax
	jz .Lbb2575
	cmpl $10, %edi
	leaq token_def_group_name(%rip), %rax
	jz .Lbb2574
	cmpl $11, %edi
	leaq fold_stmt_group_name(%rip), %rax
	jz .Lbb2573
	cmpl $12, %edi
	leaq parser_def_group_name(%rip), %rax
	jz .Lbb2572
	cmpl $13, %edi
	leaq _query_group_name(%rip), %rax
	jz .Lbb2571
	cmpl $14, %edi
	leaq child_query_group_name(%rip), %rax
	jz .Lbb2570
	cmpl $15, %edi
	leaq group_query_group_name(%rip), %rax
	jz .Lbb2569
	cmpl $16, %edi
	leaq label_group_name(%rip), %rax
	jz .Lbb2568
	cmpl $17, %edi
	leaq labelled_query_group_name(%rip), %rax
	jz .Lbb2567
	cmpl $18, %edi
	leaq highlight_def_group_name(%rip), %rax
	jz .Lbb2566
	cmpl $19, %edi
	leaq _stmt_group_name(%rip), %rax
	jz .Lbb2565
	cmpl $20, %edi
	leaq _root_group_name(%rip), %rax
	jz .Lbb2564
	cmpl $21, %edi
	leaq root_group_name(%rip), %rax
	jz .Lbb2563
	leaq err_group_name(%rip), %rax
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb2585
.Lbb2563:
	movq %rax, %rdx
	movl $4, %eax
	jmp .Lbb2585
.Lbb2564:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb2585
.Lbb2565:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb2585
.Lbb2566:
	movq %rax, %rdx
	movl $13, %eax
	jmp .Lbb2585
.Lbb2567:
	movq %rax, %rdx
	movl $14, %eax
	jmp .Lbb2585
.Lbb2568:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb2585
.Lbb2569:
	movq %rax, %rdx
	movl $11, %eax
	jmp .Lbb2585
.Lbb2570:
	movq %rax, %rdx
	movl $11, %eax
	jmp .Lbb2585
.Lbb2571:
	movq %rax, %rdx
	movl $6, %eax
	jmp .Lbb2585
.Lbb2572:
	movq %rax, %rdx
	movl $10, %eax
	jmp .Lbb2585
.Lbb2573:
	movq %rax, %rdx
	movl $9, %eax
	jmp .Lbb2585
.Lbb2574:
	movq %rax, %rdx
	movl $9, %eax
	jmp .Lbb2585
.Lbb2575:
	movq %rax, %rdx
	movl $6, %eax
	jmp .Lbb2585
.Lbb2576:
	movq %rax, %rdx
	movl $6, %eax
	jmp .Lbb2585
.Lbb2577:
	movq %rax, %rdx
	movl $3, %eax
	jmp .Lbb2585
.Lbb2578:
	movq %rax, %rdx
	movl $11, %eax
	jmp .Lbb2585
.Lbb2579:
	movq %rax, %rdx
	movl $4, %eax
	jmp .Lbb2585
.Lbb2580:
	movq %rax, %rdx
	movl $4, %eax
	jmp .Lbb2585
.Lbb2581:
	movq %rax, %rdx
	movl $9, %eax
	jmp .Lbb2585
.Lbb2582:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb2585
.Lbb2583:
	movq %rax, %rdx
	movl $5, %eax
	jmp .Lbb2585
.Lbb2584:
	movq %rax, %rdx
	movl $5, %eax
.Lbb2585:
	subq $16, %rsp
	movq %rsp, %rcx
	movq %rdx, (%rcx)
	movq %rax, 8(%rcx)
	movq (%rcx), %rax
	movq 8(%rcx), %rdx
	movq %rbp, %rsp
	subq $0, %rsp
	leave
	ret
.type group_name, @function
.size group_name, .-group_name
/* end function group_name */

.section .note.GNU-stack,"",@progbits
