# -*- coding: utf-8 -*-
##############################################################################
#
# Sinergiainformatica.net
# David Hernández. 2015
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

from osv import fields, osv


class marcas_scooter(osv.osv):
    def create(self, cr, uid, vals, context=None):
        model = vals.get('brand')
        if vals.get('brand'):
            vals['brand'] = vals['brand'].title()
        return super(marcas_scooter, self).create(cr, uid, vals, context=context)

    _name = 'marcas.scooter'
    _descripcion = 'Marcas'
    _table = 'marcas_scooter'
    _rec_name = 'brand'
    _columns = {
        'brand': fields.char('Marca', size=64, required=True, help='Marca de la moto', select=True),
    }

    # Restriccion unica al campo 
    _sql_constraints = [
        ('brand_unique', 'unique(brand)', 'La marca ya existe'),

    ]


marcas_scooter()

