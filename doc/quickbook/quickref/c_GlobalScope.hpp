
/*
 *  Copyright 2015 Matus Chochlik.
 */

//[reflexpr_GlobalScope_def

template <typename T>
__concept bool GlobalScope =
	__Scope<T> &&
	__meta::__is_global_scope_v<T>;

//]
//[reflexpr_GlobalScope_begin
__namespace_meta_begin
//]
//[reflexpr_GlobalScope_inherited_traits

template <>
struct __is_scope<GlobalScope> /*<
Inherited from __Scope.
>*/
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

//]
//[reflexpr_GlobalScope_traits

template <>
struct __is_global_scope<GlobalScope>
{
	typedef bool value_type;
	static constexpr const bool value = true;

	typedef __integral_constant<bool, value> type;

	operator value_type (void) const noexcept;
	value_type operator(void) const noexcept;
};

//]
//[reflexpr_GlobalScope_inherited_operations

template <>
struct __reflects_same<GlobalScope, GlobalScope>
{
	
	typedef bool value_type;
	static constexpr const bool value = ... /*<
	indicates if two metaobjects reflect the same base-level declaration.
	>*/;

	typedef __integral_constant<bool, value> type;

	operator bool (void) const noexcept;
	bool operator(void) const noexcept;
	
};

template <>
struct __get_source_location<GlobalScope>
{
	
	typedef __SourceLocation value_type; /*<
	returns the source location info of the declaration of the global scope reflected by a GlobalScope.
	>*/
	
};

//]
//[reflexpr_GlobalScope_operations

//]
//[reflexpr_GlobalScope_end
__namespace_meta_end
//]
