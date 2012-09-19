/*
 *  C_POINTER.h
 *  4D Plugin
 *
 *  Created by miyako on 11/01/03.
 *
 */

#ifndef __C_POINTER_H__
#define __C_POINTER_H__ 1

#include "4DPluginAPI.h"

#ifdef __cplusplus
extern "C" {
#endif
	
	
	class C_POINTER
	{
		
	private:
		
		PA_Pointer _ptr;
		
	public:
			
		void fromParamAtIndex(PackagePtr pParams, uint16_t index);

		PA_Pointer getPointer();
		
		int getIntValue();
		void setIntValue(int intValue);	
		
		C_POINTER();
		~C_POINTER();
		
	};
	
#ifdef __cplusplus
}
#endif

#endif