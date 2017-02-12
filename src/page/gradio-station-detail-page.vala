/* This file is part of Gradio.
 *
 * Gradio is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * Gradio is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with Gradio.  If not, see <http://www.gnu.org/licenses/>.
 */

using Gtk;

namespace Gradio{

	[GtkTemplate (ui = "/de/haecker-felix/gradio/ui/page/station-detail-page.ui")]
	public class StationDetailPage : Gtk.Box, Page{

		[GtkChild]
		private Label StationTitleLabel;
		[GtkChild]
		private Box StationTags;
		private TagBox tbox;

		[GtkChild]
		private Box RemoveBox;
		[GtkChild]
		private Box AddBox;

		[GtkChild]
		private Box PlayBox;
		[GtkChild]
		private Box StopBox;

		[GtkChild]
		private Label LikesLabel;

		private RadioStation station;

		public StationDetailPage(){
			setup_view();
			connect_signals();
		}

		private void connect_signals(){
			station.played.connect(() => {
				StopBox.set_visible(true);
				PlayBox.set_visible(false);
			});

			station.stopped.connect(() => {
				StopBox.set_visible(false);
				PlayBox.set_visible(true);
			});

			station.added_to_library.connect(() => {
				AddBox.set_visible(false);
				RemoveBox.set_visible(true);
			});

			station.removed_from_library.connect(() => {
				AddBox.set_visible(true);
				RemoveBox.set_visible(false);
			});
		}

		private void setup_view(){
			tbox = new TagBox();
			StationTags.add(tbox);
		}

		public void set_station(RadioStation s){
			station = s;

			reset_view();
			set_data();
		}

		private void set_data(){
			StationTitleLabel.set_text(station.Title);
			tbox.set_tags(station.Tags);

			// Play / Stop Button
			if(App.player.is_playing_station(station)){
				StopBox.set_visible(true);
				PlayBox.set_visible(false);
			}else{
				StopBox.set_visible(false);
				PlayBox.set_visible(true);
			}

			// Add / Remove Button
			if(App.library.contains_station(station)){
				RemoveBox.set_visible(true);
				AddBox.set_visible(false);
			}else{
				RemoveBox.set_visible(false);
				AddBox.set_visible(true);
			}
		}

		private void reset_view(){
			StationTitleLabel.set_text("");
		}

		[GtkCallback]
		private void LikeButton_clicked(Button b){
			station.vote();
			LikesLabel.set_text(station.Votes.to_string());
		}

		[GtkCallback]
        	private void PlayStopButton_clicked (Button button) {
			if(App.player.current_station != null && App.player.current_station.ID == station.ID)
				App.player.toggle_play_stop();
			else
				App.player.set_radio_station(station);
		}

		[GtkCallback]
		private void AddRemoveButton_clicked(Button button){
			if(App.library.contains_station(station)){
				App.library.remove_radio_station(station);
			}else{
				App.library.add_radio_station(station);
			}
		}
	}
}

			// AdditionalDataProvider.get_description.begin(station, (obj,res) => {
			// 	string desc = AdditionalDataProvider.get_description.end(res);

			// 	if(desc == "")
			// 		StationDescription.set_text("No description found");
			// 	else
			// 		StationDescription.set_text(desc);
			// });
