<%@ page import="grails.plugins.crm.product.CrmProductComposition" %><!DOCTYPE html>
<html>
<head>
    <meta name="layout" content="main">
    <g:set var="entityName" value="${message(code: 'crmProduct.label', default: 'Product')}"/>
    <title><g:message code="crmProduct.edit.title" args="[entityName, crmProduct]"/></title>
    <r:require modules="autocomplete"/>
    <r:script>
        function deletePrice(source, id) {
            if(id) {
                $.post("${createLink(action: 'deletePrice')}", {id: id}, function(data) {
                    deleteTableRow(source);
                });
            } else {
                deleteTableRow(source);
            }
        }
        function deleteComposition(source, id) {
            if(id) {
                $.post("${createLink(action: 'deleteRelated')}", {id: id}, function(data) {
                    deleteTableRow(source);
                });
            } else {
                deleteTableRow(source);
            }
        }
        $(document).ready(function () {
            // Supplier.
            $("input[name='supplierName']").autocomplete("${createLink(action: 'autocompleteSupplier')}", {
                remoteDataType: 'json',
                useCache: false,
                filter: false,
                preventDefaultReturn: true,
                minChars: 1,
                selectFirst: true,
                onItemSelect: function(item) {
                    var id = item.data[0];
                    $("#supplierId").val(id);
                    $("header h1 small").text(item.value);
                },
                onNoMatch: function() {
                    $("#supplierId").val('');
                    $("header h1 small").text($("input[name='supplierName']").val());
                }
            });

            $("#btn-add-price").click(function(ev) {
                $.get("${createLink(action: 'addPrice', id: crmProduct.id)}", function(markup) {
                    var table = $("#price-list");
                    var html = $(markup);
                    $("tbody", table).append(html);
                    table.renumberInputNames();
                    $(":input:enabled:first", html).focus();
                });
            });

            $("#btn-add-related").click(function(ev) {
                $.get("${createLink(action: 'addRelated', id: crmProduct.id)}", function(markup) {
                    var table = $("#related-list");
                    var html = $(markup);
                    $("tbody", table).append(html);
                    table.renumberInputNames();
                    $(":input:enabled:first", html).focus();
                });
            });
        });
    </r:script>
</head>

<body>

<crm:header title="crmProduct.edit.title" subtitle="${(crmProduct.supplier ?: '').encodeAsHTML()}"
            args="[entityName, crmProduct]"/>

<g:hasErrors bean="${crmProduct}">
    <crm:alert class="alert-error">
        <ul>
            <g:eachError bean="${crmProduct}" var="error">
                <li <g:if test="${error in org.springframework.validation.FieldError}">data-field-id="${error.field}"</g:if>><g:message
                        error="${error}"/></li>
            </g:eachError>
        </ul>
    </crm:alert>
</g:hasErrors>

<g:form action="edit">

    <g:hiddenField name="id" value="${crmProduct.id}"/>
    <g:hiddenField name="version" value="${crmProduct.version}"/>
    <g:hiddenField name="delete.prices" value=""/>
    <g:hiddenField name="delete.compositions" value=""/>

    <div class="tabbable">
        <ul class="nav nav-tabs">
            <li class="active"><a href="#main" data-toggle="tab"><g:message code="crmProduct.tab.main.label"/></a>
            </li>
            <li><a href="#prices" data-toggle="tab"><g:message code="crmProduct.tab.prices.label"/><crm:countIndicator
                    count="${crmProduct.prices.size()}"/></a></li>
            <li><a href="#related" data-toggle="tab"><g:message
                    code="crmProduct.tab.related.label"/><crm:countIndicator
                    count="${crmProduct.compositions.size()}"/></a></li>
            <crm:pluginViews location="tabs" var="view">
                <crm:pluginTab id="${view.id}" label="${view.label}" count="${view.model?.totalCount}"/>
            </crm:pluginViews>
        </ul>

        <div class="tab-content">
            <div class="tab-pane active" id="main">


                <div class="row-fluid">

                    <div class="span4">
                        <div class="row-fluid">
                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.number.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="number" value="${crmProduct.number}" class="span12" autofocus=""/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.name.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="name" value="${crmProduct.name}" class="span12"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.displayNumber.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="displayNumber" value="${crmProduct.displayNumber}" class="span12"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.displayName.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="displayName" value="${crmProduct.displayName}" class="span12"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.description.label"/>
                                </label>

                                <div class="controls">
                                    <g:textArea name="description" value="${crmProduct.description}" rows="4" cols="50"
                                                class="span12"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="span4">
                        <div class="row-fluid">
                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.supplier.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="supplierName" value="${crmProduct.supplierName}" class="span12"
                                                 autocomplete="off"/>
                                    <g:hiddenField name="supplierId" value="${crmProduct.supplierId}"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.suppliersNumber.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="suppliersNumber" value="${crmProduct.suppliersNumber}" class="span9"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.group.label"/>
                                </label>

                                <div class="controls">
                                    <g:select name="group.id" from="${metadata.groups}" optionKey="id"
                                              value="${crmProduct.group?.id}"/>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="span4">
                        <div class="row-fluid">
                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.barcode.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="barcode" value="${crmProduct.barcode}" class="span6"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.customsCode.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="customsCode" value="${crmProduct.customsCode}" class="span6"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.weight.label"/>
                                </label>

                                <div class="controls">
                                    <g:textField name="weight" value="${crmProduct.weight}" class="span6"/>
                                </div>
                            </div>

                            <div class="control-group">
                                <label class="control-label">
                                    <g:message code="crmProduct.enabled.label"/>
                                </label>

                                <div class="controls">
                                    <g:checkBox name="enabled" value="true" checked="${crmProduct.enabled}"/>
                                </div>
                            </div>
                        </div>
                    </div>

                </div>

                <div class="form-actions">
                    <crm:button visual="warning" icon="icon-ok icon-white" label="crmProduct.button.update.label"/>
                    <crm:button action="delete" visual="danger" icon="icon-trash icon-white"
                                label="crmProduct.button.delete.label"
                                confirm="crmProduct.button.delete.confirm.message" permission="crmProduct:delete"/>
                    <crm:button type="link" action="show" id="${crmProduct.id}"
                                icon="icon-remove"
                                label="crmProduct.button.cancel.label"/>
                </div>
            </div>

            <div class="tab-pane" id="prices">
                <table id="price-list" class="table table-striped">
                    <thead>
                    <tr>
                        <th><g:message code="crmProductPrice.priceList.label" default="Price List"/></th>
                        <th><g:message code="crmProductPrice.fromAmount.label" default="From Amount"/></th>
                        <th><g:message code="crmProductPrice.unit.label" default="Unit"/></th>
                        <th><g:message code="crmProductPrice.inPrice.label" default="Cost"/></th>
                        <th><g:message code="crmProductPrice.outPrice.label" default="Price"/></th>
                        <th><g:message code="crmProductPrice.vat.label" default="VAT"/></th>
                        <th></th>
                    </tr>
                    </thead>
                    <tbody>
                    <g:each in="${crmProduct.prices}" var="price" status="row">
                        <g:render template="price" model="${[bean: price, row: row, vatList: metadata.vatList]}"/>
                    </g:each>
                    </tbody>
                    <tfoot>
                    <tr>
                        <td colspan="7">
                            <crm:button visual="warning" icon="icon-ok icon-white" label="crmProduct.button.update.label"/>
                            <button type="button" class="btn btn-success" id="btn-add-price">
                                <i class="icon-plus icon-white"></i>
                                <g:message code="crmProductPrice.button.add.label" default="Add Price"/>
                            </button>
                        </td>
                    </tr>
                    </tfoot>
                </table>

            </div>

            <div class="tab-pane" id="related">
                <table id="related-list" class="table table-striped">
                    <thead>
                    <tr>
                        <th><g:message code="crmProductComposition.type.label"/></th>
                        <th><g:message code="crmProductComposition.quantity.label"/></th>
                        <th><g:message code="crmProductComposition.product.label"/></th>
                        <th></th>
                    </tr>
                    </thead>

                    <tbody>
                    <g:each in="${crmProduct.compositions}" var="c" status="i">
                        <g:render template="related" model="${[bean: c, row: i, productList: metadata.allProducts]}"/>
                    </g:each>
                    </tbody>

                    <tfoot>
                    <tr>
                        <td colspan="4">
                            <crm:button visual="warning" icon="icon-ok icon-white" label="crmProduct.button.update.label"/>
                            <button type="button" class="btn btn-success" id="btn-add-related">
                                <i class="icon-plus icon-white"></i>
                                <g:message code="crmProductComposition.button.add.label" default="Add Related Product"/>
                            </button>
                        </td>
                    </tr>
                    </tfoot>
                </table>
            </div>

            <crm:pluginViews location="tabs" var="view">
                <div class="tab-pane tab-${view.id}" id="${view.id}">
                    <g:render template="${view.template}" model="${view.model}" plugin="${view.plugin}"/>
                </div>
            </crm:pluginViews>
        </div>
    </div>

</g:form>

</body>
</html>
