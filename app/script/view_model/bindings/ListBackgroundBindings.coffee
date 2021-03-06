#
# Wire
# Copyright (C) 2016 Wire Swiss GmbH
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program. If not, see http://www.gnu.org/licenses/.
#

ko.bindingHandlers.switch_background = do ->

  update: (element, valueAccessor) ->
    image_resource = ko.unwrap valueAccessor()

    return if not image_resource?

    background_images = $(element).find('.background')
    background_last = background_images.last()
    background_next = background_last.clone()
    background_next.css 'opacity': '0'
    background_next.insertAfter background_last

    image_resource.load()
    .then (blob) ->
      background_next
      .find '.background-image'
      .css 'background-image': "url(#{window.URL.createObjectURL blob})"
    .then ->
      background_next
      .css 'opacity': '1'
      .one z.util.alias.animationend, background_last.remove
