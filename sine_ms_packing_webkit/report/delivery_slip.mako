## -*- coding: utf-8 -*-
<html>
<head>
    <style type="text/css">
        ${css}
        .line {border:#000 1px solid }
    </style>
</head>

<body>
    <%page expression_filter="entity"/>
    <%
    def carriage_returns(text):
        return text.replace('\n', '<br />')
    %>
    %for picking in objects:
        <% setLang(picking.partner_id.lang) %>

            <div style="float:right;margin-top:15px;margin-bottom:15px">
            <table class="recipient" style="border:1px solid #C0C0C0;">
                %if picking.partner_id.parent_id:
                <thead><th style="font-weight:bold;width=50">Dirección Envio</th></thead>
                <tr>
                    <td class="name">${picking.partner_id.parent_id.name or ''}</td>
                    <td>${picking.partner_id.title and picking.partner_id.title.name or ''} ${picking.partner_id.name }</td>
                </tr>
                %else:
                <thead><th style="font-weight:bold;width=50">Dirección Envio</th></thead>
                <tr>
                    <td nowrap style="width=250">
                    ${picking.partner_id.title and picking.partner_id.title.name or ''} ${picking.partner_id.name }<br>
                    ${picking.partner_id.street or ''}<br>
                    ${picking.partner_id.city or ''}<br>
                    ${picking.partner_id.zip or ''}, ${picking.partner_id.state_id.name or ''}, ${picking.partner_id.country_id.name or ''}
                    </td>
                    <td nowrap style="width=150" >Teléfono: ${picking.partner_id.phone or ''}<br>
                        Móbil: ${picking.partner_id.mobile or ''}<br>
                        Email: ${picking.partner_id.email or ''}</td>
                </tr>
                %endif
            </table>

            </div>
            <div style="float:left;margin-top:15px;margin-bottom:15px">
            <%
            invoice_addr = invoice_address(picking)
            %>
            <table class="invoice" style="border:1px solid #C0C0C0;">
                <thead><th style="font-weight:bold;width=50">Dirección Facturación</th></thead>
                <tr>

                <td nowrap style="width=250">
                ${invoice_addr.title and invoice_addr.title.name or ''} ${invoice_addr.name }<br>
                ${invoice_addr.street or ''}<br>
                ${invoice_addr.city or ''}<br>
                ${invoice_addr.zip or ''}, ${invoice_addr.state_id.name or ''}, ${invoice_addr.country_id.name or ''}</td>
                <td nowrap style="width=150" >Teléfono: ${invoice_addr.phone or ''}<br>
                        Móbil: ${invoice_addr.mobile or ''}<br>
                        Email: ${invoice_addr.email or ''}<br>
                </td></tr>
            </table>
            </div>


        <h1 style="clear:both;">${_(u'Picking List') } ${picking.name}</h1>

        <table class="basic_table" width="100%">
            %if picking.origin and picking.sale_id:
                <tr>
                    <td style="font-weight:bold;">${_("Vendedor")}</td>
                    <td style="font-weight:bold;">${_("Pedido")}</td>
                    <td style="font-weight:bold;">${_("C. Final")}</td>
                    <td style="font-weight:bold;">${_("F. envío")}</td>
                    <td style="font-weight:bold;">${_('Weight')}</td>
                    <td style="font-weight:bold;">${_('Transporte')}</td>
                    <td style="font-weight:bold;">${_('Nº Track')}</td>
                    <td style="font-weight:bold;">${_("Total €")}</td>


                </tr>
                <tr>
                    <td>${user.name}</td>

                    <td>${picking.origin or ''}</td>

                    %if 'MAG-4' in picking.origin:
                        <td>Toptaller</td>
                    %elif 'MAG-1' in picking.origin:
                        <td>Motoscoot</td>
                    %elif 'SO' in picking.origin and picking.partner_id.category_id:

                        %if 'General' in picking.partner_id.category_id.name or 'Pilot' in picking.partner_id.category_id.name:
                            <td>Motoscoot</td>
                        %elif 'Taller' in picking.partner_id.category_id.name or 'Taller std' in picking.partner_id.category_id.name:
                            <td>Toptaller</td>
                        %endif

                    %elif 'SO' in picking.origin and not picking.partner_id.category_id:
                        <td>N/A</td>
                    %endif

                        <td>${formatLang(picking.date_done, date=True)}</td>
                        <td>${picking.weight}</td>
                        <td>${picking.carrier_id and picking.carrier_id.carrier_file_id.name or ''}</td>
                        <td>${picking.carrier_tracking_ref or ''}</td>
                        <td>${formatLang(picking.sale_id.amount_total)}</td>
            %elif not picking.origin and not picking.sale_id:
            <tr>
                <td style="font-weight:bold;">${_("Vendedor")}</td>
                <td style="font-weight:bold;">${_("Pedido")}</td>
                <td style="font-weight:bold;">${_("C. Final")}</td>
                <td style="font-weight:bold;">${_("F. envío")}</td>
                <td style="font-weight:bold;">${_('Weight')}</td>
                <td style="font-weight:bold;">${_('Transporte')}</td>
                <td style="font-weight:bold;">${_('Nº Track')}</td>
                <td style="font-weight:bold;">${_("Total €")}</td>


            </tr>
            <tr>
                <td>${user.name}</td>

                    <td>${picking.origin or ''}</td>

                    %if 'General' in picking.partner_id.category_id.name or 'Pilot' in picking.partner_id.category_id.name:
                        <td>Motoscoot</td>
                    %elif 'Taller' in picking.partner_id.category_id.name or 'Taller std' in picking.partner_id.category_id.name:
                        <td>Toptaller</td>
                    %else:
                        <td>Final</td>
                    %endif
                <td>${formatLang(picking.date_done, date=True)}</td>
                <td>${picking.weight}</td>
                <td>${picking.carrier_id and picking.carrier_id.carrier_file_id.name or ''}</td>
                <td>${picking.carrier_tracking_ref or ''}</td>
                <td>N/A</td>
            </tr>
            %endif

        </table>

        <table class="list_sale_table" width="100%" style="margin-top: 20px;">
            <thead>
            %if picking.origin and picking.sale_id:
                <tr>
                    <th style="text-align:left; ">${_("Qt")}</th>
                    <th style="text-align:left; ">${_("Ref")}</th>
                    <th style="text-align:left; ">${_("Marca")}</th>
                    <th style="text-align:left; ">${_("Description")}</th>
                    <!--<th style="text-align:left; ">${_("Ubicación")}</th>-->
                    <th style="text-align:left; ">${_("GRN")}</th>
                    <th style="text-align:left; ">${_("BCN")}</th>
                    <th style="text-align:left; ">${_("PT")}</th>
                </tr>
                </thead>
                <tbody>
                %for line in picking.move_lines:
                    <tr style="border:1px solid #000">
                        <td style="text-align:left; " >${ formatLang( line.product_qty ) }</td>
                        <td style="text-align:left; " ><b>${( line.product_id.default_code )}</b></td>
                        <td style="text-align:left; " >${( line.product_id.product_brand_id.name )}</td>
                        <td style="text-align:left; " >${( line.product_id.name ) }</td>
                        <!--<td style="text-align:left; ">${( line.product_id.loc_rack )}  ${( line.product_id.loc_row )}  ${( line.product_id.loc_case)}</td>-->
                        %for pick in picking.sale_id.order_line:
                        <td style="text-align:left;" >${ (pick.stock_grn[0]) }</td>
                        <td style="text-align:left;" >${ (pick.stock_bcn[0]) }</td>
                        <td style="text-align:left;" >${ (pick.stock_pt[0]) }</td>
                        %endfor
                    </tr>
                %endfor

            %elif not picking.origin and not picking.sale_id:
                    <tr>
                        <th style="text-align:left; ">${_("Qt")}</th>
                        <th style="text-align:left; ">${_("Ref")}</th>
                        <th style="text-align:left; ">${_("Marca")}</th>
                        <th style="text-align:left; ">${_("Description")}</th>
                        <!--<th style="text-align:left; ">${_("Ubicación")}</th>-->
                        <th style="text-align:left; ">${_("GRN")}</th>
                        <th style="text-align:left; ">${_("BCN")}</th>
                        <th style="text-align:left; ">${_("PT")}</th>
                    </tr>
                </thead>
                <tbody>
                %for line in picking.move_lines:
                    <tr style="border:1px solid #000">
                        <td style="text-align:left; " >${ formatLang( line.product_qty ) }</td>
                        <td style="text-align:left; " ><b>${( line.product_id.default_code )}</b></td>
                        <td style="text-align:left; " >${( line.product_id.product_brand_id.name )}</td>
                        <td style="text-align:left; " >${( line.product_id.name ) }</td>
                        <!--<td style="text-align:left; ">${( line.product_id.loc_rack )}  ${( line.product_id.loc_row )}  ${( line.product_id.loc_case)}</td>-->
                        <td style="text-align:left;" > N/A </td>
                        <td style="text-align:left;" > N/A </td>
                        <td style="text-align:left;" > N/A </td>
                    </tr>
                %endfor
            %endif

        </table>

        <br/>
        %if picking.note :
            <p class="std_text">${picking.note | carriage_returns}</p>
        %endif

        <p style="page-break-after: always"/>
        <br/>
    %endfor
</body>
</html>