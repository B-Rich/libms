#include "common.h"

void ms_init(int X, ms_origin_t org, ms_state_t *st)
{
	ms_X(st)=X;
	ms_Xm2(st)=ms_X(st)*2;
	ms_Xm2p2(st)=ms_Xm2(st)+2;
	ms_Xs1(st)=ms_X(st)-1;
	ms_Ceilings(st)=ms_X(st)*ms_X(st);

	if(org==MS_ORIGIN_ZERO){
		/* \sum_{i=0}^{X^2-1}i=\frac{1}{2}X(X^2-1) */
		ms_OneLine(st)=ms_X(st)*(ms_Ceilings(st)-1)/2;
	}else if(org==MS_ORIGIN_ONE){
		/* \sum_{i=1}^{X^2}i=\frac{1}{2}X(X^2+1) */
		ms_OneLine(st)=ms_X(st)*(ms_Ceilings(st)+1)/2;
	}
	st->org = org;

	st->is_is_ms_init_called=0;
	st->is_str_to_ms_init_called=0;
	st->is_ms_state_print_info_init_called=0;
	st->is_output_ms_init_called=0;
	st->is_ms_mem_basics_init_called=0;
	st->is_ms_rotate_init_called=0;
	st->is_ms_bin_init_called=0;
	st->is_ms_conv_init_called=0;

	is_ms_init(st);
	str_to_ms_init(st);
	ms_state_print_info_init(st);
	output_ms_init(st);
	ms_mem_basics_init(st);
	ms_rotate_init(st);
	ms_bin_init(st);
	ms_conv_init(st);

	return;
}

void ms_finalize(ms_state_t *st)
{
	st->is_is_ms_finalize_called=0;
	st->is_str_to_ms_finalize_called=0;
	st->is_ms_state_print_info_finalize_called=0;
	st->is_output_ms_finalize_called=0;
	st->is_ms_mem_basics_finalize_called=0;
	st->is_ms_rotate_finalize_called=0;
	st->is_ms_bin_finalize_called=0;
	st->is_ms_conv_finalize_called=0;

	is_ms_finalize(st);
	str_to_ms_finalize(st);
	ms_state_print_info_finalize(st);
	output_ms_finalize(st);
	ms_mem_basics_finalize(st);
	ms_rotate_finalize(st);
	ms_bin_finalize(st);
	ms_conv_finalize(st);

	return;
}
