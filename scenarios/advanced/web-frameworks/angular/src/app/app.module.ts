import { NgModule } from '@angular/core';
import { BrowserModule } from '@angular/platform-browser';
import { FormsModule } from '@angular/forms';
import { RouterModule } from '@angular/router';

import { AppComponent } from './app.component';
import { HomeComponent } from './components/home/home.component';
import { DataTableComponent } from './components/data-table/data-table.component';
import { WizardComponent } from './components/wizard/wizard.component';
import { DashboardComponent } from './components/dashboard/dashboard.component';
import { MediaPlayerComponent } from './components/media-player/media-player.component';
import { ShoppingCartComponent } from './components/shopping-cart/shopping-cart.component';
import { CalendarComponent } from './components/calendar/calendar.component';
import { RichTextEditorComponent } from './components/rich-text-editor/rich-text-editor.component';
import { SearchInterfaceComponent } from './components/search-interface/search-interface.component';
import { InteractiveMapComponent } from './components/interactive-map/interactive-map.component';
import { SocialFeedComponent } from './components/social-feed/social-feed.component';

@NgModule({
  declarations: [
    AppComponent,
    HomeComponent,
    DataTableComponent,
    WizardComponent,
    DashboardComponent,
    MediaPlayerComponent,
    ShoppingCartComponent,
    CalendarComponent,
    RichTextEditorComponent,
    SearchInterfaceComponent,
    InteractiveMapComponent,
    SocialFeedComponent
  ],
  imports: [
    BrowserModule,
    FormsModule,
    RouterModule.forRoot([
      { path: '', component: HomeComponent },
      { path: 'data-table', component: DataTableComponent },
      { path: 'wizard', component: WizardComponent },
      { path: 'dashboard', component: DashboardComponent },
      { path: 'media-player', component: MediaPlayerComponent },
      { path: 'shopping-cart', component: ShoppingCartComponent },
      { path: 'calendar', component: CalendarComponent },
      { path: 'rich-text-editor', component: RichTextEditorComponent },
      { path: 'search-interface', component: SearchInterfaceComponent },
      { path: 'interactive-map', component: InteractiveMapComponent },
      { path: 'social-feed', component: SocialFeedComponent },
      { path: '**', redirectTo: '' }
    ])
  ],
  providers: [],
  bootstrap: [AppComponent]
})
export class AppModule { }
