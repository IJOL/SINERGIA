# -*- coding: utf-8 -*-
##############################################################################
# Sinergiainformatica.net
# David Hernández. 2015
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


class scooter_asociaciones(osv.osv):
    _name = 'scooter.asociaciones'
    _descripcion = 'Listado de Asociaciones'
    _table = 'scooter_asociaciones'
    _rec_name = 'model_id'
    _columns = {

        'type': fields.selection((('QUAD', 'Quad'), ('SCOOT', 'Scooters 50cc'), ('SCOOT2', 'Scooter 100-600cc'),
                                  ('MARCH2', 'Marchas 125cc'), ('PBKE', 'PitBike 4T'), ('MARCH', 'Marchas 50cc-80cc'),
                                  ('VESP', 'Vespas Clásicas 50-200cc'), ('MXSC', 'Maxiscooter'), ('0', 'Universal')),
                                 'Selecciona tipo',
                                 required=False, select=True),
        'brand_id': fields.many2one('marcas.scooter', 'Marca', required=False, readonly=False, select=True),
        'model_id': fields.many2one('scooter.model', 'Modelo', required=False, readonly=False, select=True),
        'compatible_with_ids': fields.many2many('product.product', 'scooter_compat_with_product_rel', 'scooter_id',
                                                'product_id', string="Compatible con", select=True),
    }

    _order = "brand_id ASC"


scooter_asociaciones()
