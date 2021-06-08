<#assign
    known = Session.SPRING_SECURITY_CONTEXT??
>

<#if known>
    <#assign
        user = Session.SPRING_SECURITY_CONTEXT.authentication.principal
        name = user.getUsername()
        currentUserID = user.getId()
    >
<#else>
    <#assign
        name = "unknown"
        currentUserID = -1
    >
</#if>