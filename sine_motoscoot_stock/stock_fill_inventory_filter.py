# -*- coding: utf-8 -*-
##############################################################################
#    Sinergiainformatica.net
#    David Hernández
#    2015.
#    Add a brand filter in fill inventory function to make inventories by brand
#
#
#    This program is free software: you can redistribute it and/or modify
#    it under the terms of the GNU Affero General Public License as
#    published by the Free Software Foundation, either version 3 of the
#    License, or (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU Affero General Public License for more details.
#
#    You should have received a copy of the GNU Affero General Public License
#    along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
##############################################################################

from openerp.osv import fields, osv, orm


class stock_fill_inventory(osv.osv_memory):
    _inherit = "stock.fill.inventory"

    _columns = {
        'product_brand': fields.many2one('product.brand', 'Marca')
    }