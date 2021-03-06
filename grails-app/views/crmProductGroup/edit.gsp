<!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'crmProductGroup.label', default: 'Product Group')}"/>
    <title><g:message code="crmProductGroup.edit.title" args="[entityName, crmProductGroup]"/></title>
</head>

<body>

<crm:header title="crmProductGroup.edit.title" args="[entityName, crmProductGroup]"/>

<div class="row-fluid">
    <div class="span9">

        <g:hasErrors bean="${crmProductGroup}">
            <crm:alert class="alert-error">
                <ul>
                    <g:eachError bean="${crmProductGroup}" var="error">
                        <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                                error="${error}"/></li>
                    </g:eachError>
                </ul>
            </crm:alert>
        </g:hasErrors>

        <g:form class="form-horizontal" action="edit"
                id="${crmProductGroup?.id}">
            <g:hiddenField name="version" value="${crmProductGroup?.version}"/>

            <f:with bean="crmProductGroup">
                <f:field property="name" input-autofocus=""/>
                <f:field property="description"/>
                <f:field property="param"/>
                <f:field property="orderIndex"/>
                <f:field property="enabled"/>
            </f:with>

            <div class="form-actions">
                <crm:button visual="warning" icon="icon-ok icon-white" label="crmProductGroup.button.update.label"/>
                <crm:button action="delete" visual="danger" icon="icon-trash icon-white"
                            label="crmProductGroup.button.delete.label"
                            confirm="crmProductGroup.button.delete.confirm.message"
                            permission="crmProductGroup:delete"/>
                <crm:button type="link" action="list"
                            icon="icon-remove"
                            label="crmProductGroup.button.cancel.label"/>
            </div>
        </g:form>
    </div>

    <div class="span3">
        <crm:submenu/>
    </div>
</div>

</body>
</html>
