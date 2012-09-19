/*
 *  C_POINTER.cpp
 *  4D Plugin
 *
 *  Created by miyako on 11/01/03.
 *
 */

#include "C_POINTER.h"

void C_POINTER::fromParamAtIndex(PackagePtr pParams, uint16_t index)
{	
	if(index){
		if (PA_IsCompiled(1))
		{
			PA_Variable *ptr = ((PA_Variable*)pParams[index - 1]);
			
			if (ptr->fType == eVK_Pointer)
				if (!(ptr->uValue.fPointer == 0))
					this->_ptr = *ptr->uValue.fPointer;
		}else{
			this->_ptr = ((PA_Pointer)pParams[index - 1]);
		}
	}
}

PA_Pointer C_POINTER::getPointer()
{
	return this->_ptr;
}

void C_POINTER::setIntValue(int intValue)
{
	PA_Variable intVar = PA_CreateVariable(eVK_Longint);
	PA_SetLongintVariable(&intVar, intValue);
	
	switch (PA_GetPointerValueKind(this->_ptr)) {
		case eVK_Longint:
		case eVK_Real:
		case eVK_Time:			
			PA_SetPointerValue(this->_ptr, intVar);
			break;		
		default:
			break;
	}

}

int C_POINTER::getIntValue()
{
	int intValue = 0;
	
	switch (PA_GetPointerValueKind(this->_ptr)) {
		case eVK_Longint:
			intValue = (int)PA_GetLongintVariable(PA_GetPointerValue(this->_ptr));
			break;			
		case eVK_Real:
			intValue = (int)PA_GetRealVariable(PA_GetPointerValue(this->_ptr));
			break;
		case eVK_Time:
			intValue = (int)PA_GetTimeVariable(PA_GetPointerValue(this->_ptr));
			break;			
		default:
			break;
	}

	return intValue;
}

C_POINTER::C_POINTER() : _ptr(0)
{
	
}

C_POINTER::~C_POINTER()
{ 
	
}
